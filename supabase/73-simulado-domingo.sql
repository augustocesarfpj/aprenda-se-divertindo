-- Aprenda se Divertindo · 73 · Simulado de Domingo
-- Rode depois do 72-meta-estudo-50.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Como funciona:
--   • Cada trilha pode ter um simulado por domingo, com questões no formato de prova (A a E, texto-base opcional).
--   • O simulado só abre no domingo marcado, das 0h às 23h59 (horário de Brasília), para quem tem conta.
--   • Cada pessoa faz uma vez. O relógio começa quando ela inicia; o prazo é o tempo da prova ou 23h59, o que vier antes.
--   • As respostas ficam salvas no servidor durante a prova. Acabou o tempo, a prova é entregue com o que estiver marcado.
--   • A nota é calculada aqui no servidor: o gabarito nunca vai para o celular antes de o domingo acabar.
--   • Ranking do simulado por trilha: mais acertos primeiro; empate, quem fez em menos tempo.
--   • O gabarito comentado é liberado na segunda-feira, às 0h.
--   • A administração (admin.html, aba Simulados) cria o simulado, carrega as questões e publica.

-- ============ tabelas ============
create table if not exists public.simulados (
  id          bigint generated always as identity primary key,
  trilha      text not null check (trilha in ('geral','policial','tribunais','fiscal','saude','enem','administrativa')),
  data        date not null check (extract(isodow from data) = 7),
  titulo      text not null default '' check (char_length(titulo) <= 120),
  estilo      text not null default 'FGV/FCC' check (char_length(estilo) <= 40),
  duracao_min smallint not null default 240 check (duracao_min between 10 and 600),
  publicado   boolean not null default false,
  criado_em   timestamptz not null default now(),
  unique (trilha, data)
);

create table if not exists public.simulado_questoes (
  simulado_id bigint not null references public.simulados (id) on delete cascade,
  ordem       smallint not null check (ordem >= 1),
  materia     text not null,
  texto_base  text,
  enunciado   text not null,
  opcoes      jsonb not null check (jsonb_typeof(opcoes) = 'array' and jsonb_array_length(opcoes) = 5),
  gabarito    smallint not null check (gabarito between 0 and 4),
  explicacao  text not null default '',
  primary key (simulado_id, ordem)
);

create table if not exists public.simulado_respostas (
  simulado_id bigint not null references public.simulados (id) on delete cascade,
  user_id     uuid not null references auth.users (id) on delete cascade,
  iniciado_em timestamptz not null default now(),
  respostas   jsonb not null default '{}'::jsonb,
  entregue_em timestamptz,
  acertos     smallint,
  total       smallint,
  tempo_seg   integer,
  primary key (simulado_id, user_id)
);
create index if not exists simulado_respostas_rank on public.simulado_respostas (simulado_id, acertos desc, tempo_seg) where entregue_em is not null;

alter table public.simulados enable row level security;
alter table public.simulado_questoes enable row level security;
alter table public.simulado_respostas enable row level security;
revoke all on public.simulados, public.simulado_questoes, public.simulado_respostas from anon, authenticated;

-- ============ relógio (separado para poder testar) ============
create or replace function public.sim_agora()
returns timestamptz language sql stable set search_path = '' as $$ select now() $$;

create or replace function public.sim_hoje()
returns date language sql stable set search_path = '' as $$ select (public.sim_agora() at time zone 'America/Sao_Paulo')::date $$;

-- fim do domingo do simulado (segunda 0h, horário de Brasília)
create or replace function public.sim_fim(p_data date)
returns timestamptz language sql immutable set search_path = '' as $$ select ((p_data + 1)::timestamp at time zone 'America/Sao_Paulo') $$;

-- prazo de uma pessoa: tempo da prova ou fim do domingo, o que vier antes
create or replace function public.sim_prazo(p_ini timestamptz, p_dur smallint, p_data date)
returns timestamptz language sql immutable set search_path = '' as $$ select least(p_ini + make_interval(mins => p_dur), public.sim_fim(p_data)) $$;

-- ============ correção (interna) ============
create or replace function public.sim_corrigir(p_simulado bigint, p_user uuid)
returns void language plpgsql security definer set search_path = '' as $$
declare s public.simulados; r public.simulado_respostas; ac integer; tot integer; fim timestamptz;
begin
  select * into s from public.simulados where id = p_simulado;
  select * into r from public.simulado_respostas where simulado_id = p_simulado and user_id = p_user for update;
  if r.user_id is null or r.entregue_em is not null then return; end if;
  select count(*) filter (where (r.respostas ->> q.ordem::text) ~ '^[0-4]$' and (r.respostas ->> q.ordem::text)::int = q.gabarito), count(*)
    into ac, tot from public.simulado_questoes q where q.simulado_id = p_simulado;
  fim := least(public.sim_agora(), public.sim_prazo(r.iniciado_em, s.duracao_min, s.data));
  update public.simulado_respostas
     set entregue_em = fim, acertos = ac, total = tot,
         tempo_seg = greatest(0, extract(epoch from fim - r.iniciado_em)::int)
   where simulado_id = p_simulado and user_id = p_user;
end $$;

-- entrega automática de quem estourou o prazo e não entregou
create or replace function public.sim_fechar_vencidos(p_simulado bigint)
returns void language plpgsql security definer set search_path = '' as $$
declare s public.simulados; x record;
begin
  select * into s from public.simulados where id = p_simulado;
  if s.id is null then return; end if;
  for x in select user_id from public.simulado_respostas
            where simulado_id = p_simulado and entregue_em is null
              and public.sim_prazo(iniciado_em, s.duracao_min, s.data) <= public.sim_agora()
  loop perform public.sim_corrigir(p_simulado, x.user_id); end loop;
end $$;

create or replace function public.sim_cabecalho(s public.simulados)
returns jsonb language sql stable set search_path = '' as $$
  select jsonb_build_object('id', s.id, 'trilha', s.trilha, 'data', s.data, 'titulo', s.titulo, 'estilo', s.estilo,
    'duracao_min', s.duracao_min, 'n_questoes', (select count(*) from public.simulado_questoes q where q.simulado_id = s.id),
    'fim', public.sim_fim(s.data), 'liberado', public.sim_agora() >= public.sim_fim(s.data))
$$;

-- minha situação num simulado
create or replace function public.sim_meu(p_simulado bigint, p_user uuid)
returns jsonb language plpgsql stable security definer set search_path = '' as $$
declare s public.simulados; r public.simulado_respostas; pos integer; part integer;
begin
  if p_user is null then return null; end if;
  select * into s from public.simulados where id = p_simulado;
  select * into r from public.simulado_respostas where simulado_id = p_simulado and user_id = p_user;
  if r.user_id is null then return jsonb_build_object('status', 'nao_iniciado'); end if;
  select count(*) into part from public.simulado_respostas where simulado_id = p_simulado and entregue_em is not null;
  if r.entregue_em is null then
    return jsonb_build_object('status', 'fazendo', 'prazo', public.sim_prazo(r.iniciado_em, s.duracao_min, s.data),
      'respondidas', (select count(*) from jsonb_each_text(r.respostas) e where e.value ~ '^[0-4]$'));
  end if;
  select 1 + count(*) into pos from public.simulado_respostas o
   where o.simulado_id = p_simulado and o.entregue_em is not null
     and (o.acertos > r.acertos or (o.acertos = r.acertos and o.tempo_seg < r.tempo_seg));
  return jsonb_build_object('status', 'entregue', 'acertos', r.acertos, 'total', r.total, 'tempo_seg', r.tempo_seg,
    'posicao', pos, 'participantes', part);
end $$;

-- ============ jogador ============
-- o que mostrar na capa para uma trilha
create or replace function public.simulado_info(p_trilha text)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare hoje date := public.sim_hoje(); a public.simulados; p public.simulados; u public.simulados; uid uuid := auth.uid();
begin
  select * into a from public.simulados where trilha = p_trilha and publicado and data = hoje;
  select * into p from public.simulados where trilha = p_trilha and publicado and data > hoje order by data limit 1;
  select * into u from public.simulados where trilha = p_trilha and publicado and data < hoje order by data desc limit 1;
  if a.id is not null then perform public.sim_fechar_vencidos(a.id); end if;
  if u.id is not null then perform public.sim_fechar_vencidos(u.id); end if;
  return jsonb_build_object(
    'agora', public.sim_agora(), 'hoje', hoje, 'domingo', extract(isodow from hoje) = 7,
    'atual', case when a.id is null then null else public.sim_cabecalho(a) || jsonb_build_object('meu', public.sim_meu(a.id, uid),
       'participantes', (select count(*) from public.simulado_respostas r where r.simulado_id = a.id)) end,
    'proximo', case when p.id is null then null else public.sim_cabecalho(p) end,
    'ultimo', case when u.id is null then null else public.sim_cabecalho(u) || jsonb_build_object('meu', public.sim_meu(u.id, uid),
       'participantes', (select count(*) from public.simulado_respostas r where r.simulado_id = u.id and r.entregue_em is not null)) end);
end $$;

-- começar (ou continuar) a prova: devolve as questões SEM gabarito
create or replace function public.simulado_iniciar(p_simulado bigint)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); s public.simulados; r public.simulado_respostas;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  select * into s from public.simulados where id = p_simulado and publicado;
  if s.id is null then raise exception 'NAO_ENCONTRADO'; end if;
  if s.data <> public.sim_hoje() then raise exception 'FECHADO'; end if;
  if not exists (select 1 from public.simulado_questoes q where q.simulado_id = s.id) then raise exception 'SEM_QUESTOES'; end if;
  insert into public.simulado_respostas (simulado_id, user_id, iniciado_em) values (s.id, uid, public.sim_agora())
  on conflict do nothing;
  perform public.sim_fechar_vencidos(s.id);
  select * into r from public.simulado_respostas where simulado_id = s.id and user_id = uid;
  if r.entregue_em is not null then raise exception 'JA_ENTREGUE'; end if;
  return public.sim_cabecalho(s) || jsonb_build_object(
    'agora', public.sim_agora(), 'iniciado_em', r.iniciado_em,
    'prazo', public.sim_prazo(r.iniciado_em, s.duracao_min, s.data), 'respostas', r.respostas,
    'questoes', (select coalesce(jsonb_agg(jsonb_build_object('ordem', q.ordem, 'materia', q.materia, 'texto_base', q.texto_base,
                   'enunciado', q.enunciado, 'opcoes', q.opcoes) order by q.ordem), '[]'::jsonb)
                 from public.simulado_questoes q where q.simulado_id = s.id));
end $$;

-- limpa o que vem do celular: só {"ordem": 0..4}
create or replace function public.sim_limpar(p jsonb, p_max integer)
returns jsonb language sql immutable set search_path = '' as $$
  select coalesce(jsonb_object_agg(e.key, (e.value)::int), '{}'::jsonb)
  from jsonb_each_text(case when jsonb_typeof(p) = 'object' then p else '{}'::jsonb end) e
  where e.key ~ '^[0-9]{1,3}$' and e.key::int between 1 and p_max and e.value ~ '^[0-4]$'
$$;

-- salvar respostas durante a prova
create or replace function public.simulado_salvar(p_simulado bigint, p_respostas jsonb)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); s public.simulados; r public.simulado_respostas; prazo timestamptz;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  select * into s from public.simulados where id = p_simulado;
  select * into r from public.simulado_respostas where simulado_id = p_simulado and user_id = uid for update;
  if r.user_id is null then raise exception 'NAO_INICIADO'; end if;
  if r.entregue_em is not null then return jsonb_build_object('encerrado', true); end if;
  prazo := public.sim_prazo(r.iniciado_em, s.duracao_min, s.data);
  if public.sim_agora() > prazo + interval '1 minute' then
    perform public.sim_corrigir(p_simulado, uid);
    return jsonb_build_object('encerrado', true);
  end if;
  update public.simulado_respostas set respostas = public.sim_limpar(p_respostas, 300)
   where simulado_id = p_simulado and user_id = uid;
  return jsonb_build_object('encerrado', false, 'prazo', prazo, 'agora', public.sim_agora());
end $$;

-- entregar a prova
create or replace function public.simulado_entregar(p_simulado bigint, p_respostas jsonb)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); s public.simulados; r public.simulado_respostas;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  select * into s from public.simulados where id = p_simulado;
  select * into r from public.simulado_respostas where simulado_id = p_simulado and user_id = uid for update;
  if r.user_id is null then raise exception 'NAO_INICIADO'; end if;
  if r.entregue_em is null and p_respostas is not null
     and public.sim_agora() <= public.sim_prazo(r.iniciado_em, s.duracao_min, s.data) + interval '1 minute' then
    update public.simulado_respostas set respostas = public.sim_limpar(p_respostas, 300)
     where simulado_id = p_simulado and user_id = uid;
  end if;
  perform public.sim_corrigir(p_simulado, uid);
  return public.simulado_resultado(p_simulado);
end $$;

-- resultado, ranking e (depois do domingo) gabarito comentado
create or replace function public.simulado_resultado(p_simulado bigint)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); s public.simulados; r public.simulado_respostas; lib boolean;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  select * into s from public.simulados where id = p_simulado and publicado;
  if s.id is null then raise exception 'NAO_ENCONTRADO'; end if;
  perform public.sim_fechar_vencidos(s.id);
  select * into r from public.simulado_respostas where simulado_id = s.id and user_id = uid;
  lib := public.sim_agora() >= public.sim_fim(s.data);
  if (r.entregue_em is null) and not lib then raise exception 'NAO_ENTREGUE'; end if;
  return public.sim_cabecalho(s) || jsonb_build_object(
    'meu', public.sim_meu(s.id, uid),
    'por_materia', case when r.entregue_em is null then '[]'::jsonb else (
       select coalesce(jsonb_agg(jsonb_build_object('materia', x.materia, 'acertos', x.ac, 'total', x.tot) order by x.tot desc, x.materia), '[]'::jsonb)
       from (select q.materia, count(*) tot,
                    count(*) filter (where (r.respostas ->> q.ordem::text) ~ '^[0-4]$' and (r.respostas ->> q.ordem::text)::int = q.gabarito) ac
               from public.simulado_questoes q where q.simulado_id = s.id group by q.materia) x) end,
    'ranking', (select coalesce(jsonb_agg(jsonb_build_object('pos', z.pos, 'nome', z.nome, 'acertos', z.acertos, 'total', z.total,
                   'tempo_seg', z.tempo_seg, 'eu', z.user_id = uid) order by z.pos, z.nome), '[]'::jsonb)
                from (select rank() over (order by o.acertos desc, o.tempo_seg) pos, coalesce(pf.nome, 'Jogador') nome,
                             o.acertos, o.total, o.tempo_seg, o.user_id
                        from public.simulado_respostas o left join public.perfis pf on pf.id = o.user_id
                       where o.simulado_id = s.id and o.entregue_em is not null
                       order by o.acertos desc, o.tempo_seg limit 50) z),
    'gabarito', case when not lib then null else (
       select coalesce(jsonb_agg(jsonb_build_object('ordem', q.ordem, 'materia', q.materia, 'texto_base', q.texto_base,
                'enunciado', q.enunciado, 'opcoes', q.opcoes, 'gabarito', q.gabarito, 'explicacao', q.explicacao,
                'minha', case when (r.respostas ->> q.ordem::text) ~ '^[0-4]$' then (r.respostas ->> q.ordem::text)::int end) order by q.ordem), '[]'::jsonb)
         from public.simulado_questoes q where q.simulado_id = s.id) end);
end $$;

-- ============ administração ============
create or replace function public.admin_simulados()
returns jsonb language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return (select coalesce(jsonb_agg(jsonb_build_object('id', s.id, 'trilha', s.trilha, 'data', s.data, 'titulo', s.titulo, 'estilo', s.estilo,
     'duracao_min', s.duracao_min, 'publicado', s.publicado,
     'n_questoes', (select count(*) from public.simulado_questoes q where q.simulado_id = s.id),
     'iniciados', (select count(*) from public.simulado_respostas r where r.simulado_id = s.id),
     'entregues', (select count(*) from public.simulado_respostas r where r.simulado_id = s.id and r.entregue_em is not null),
     'media', (select round(avg(r.acertos)::numeric, 1) from public.simulado_respostas r where r.simulado_id = s.id and r.entregue_em is not null))
     order by s.data desc, s.trilha), '[]'::jsonb) from public.simulados s);
end $$;

create or replace function public.admin_simulado_salvar(p_id bigint, p_trilha text, p_data date, p_titulo text, p_estilo text, p_duracao integer, p_publicado boolean)
returns bigint language plpgsql security definer set search_path = '' as $$
declare nid bigint;
begin
  perform public.admin_exigir();
  if extract(isodow from p_data) <> 7 then raise exception 'NAO_DOMINGO'; end if;
  if p_publicado and (p_id is null or not exists (select 1 from public.simulado_questoes q where q.simulado_id = p_id)) then raise exception 'SEM_QUESTOES'; end if;
  if p_id is null then
    insert into public.simulados (trilha, data, titulo, estilo, duracao_min, publicado)
    values (p_trilha, p_data, coalesce(trim(p_titulo), ''), coalesce(nullif(trim(p_estilo), ''), 'FGV/FCC'), p_duracao, coalesce(p_publicado, false))
    returning id into nid;
    return nid;
  end if;
  if exists (select 1 from public.simulado_respostas r where r.simulado_id = p_id)
     and exists (select 1 from public.simulados s where s.id = p_id and (s.trilha <> p_trilha or s.data <> p_data)) then raise exception 'JA_INICIADO'; end if;
  update public.simulados set trilha = p_trilha, data = p_data, titulo = coalesce(trim(p_titulo), ''),
         estilo = coalesce(nullif(trim(p_estilo), ''), 'FGV/FCC'), duracao_min = p_duracao, publicado = coalesce(p_publicado, false)
   where id = p_id;
  if not found then raise exception 'NAO_ENCONTRADO'; end if;
  return p_id;
end $$;

-- substitui todas as questões de um simulado (antes de alguém começar)
-- cada item: {"materia","texto_base","enunciado","opcoes":[5 textos],"gabarito":0-4 ou "A"-"E","explicacao"}
create or replace function public.admin_simulado_questoes_importar(p_id bigint, p_lista jsonb)
returns integer language plpgsql security definer set search_path = '' as $$
declare n integer;
begin
  perform public.admin_exigir();
  if not exists (select 1 from public.simulados where id = p_id) then raise exception 'NAO_ENCONTRADO'; end if;
  if exists (select 1 from public.simulado_respostas r where r.simulado_id = p_id) then raise exception 'JA_INICIADO'; end if;
  if jsonb_typeof(p_lista) <> 'array' or jsonb_array_length(p_lista) = 0 then raise exception 'LISTA_VAZIA'; end if;
  if exists (select 1 from jsonb_array_elements(p_lista) e
              where coalesce(trim(e ->> 'enunciado'), '') = '' or coalesce(trim(e ->> 'materia'), '') = ''
                 or jsonb_typeof(e -> 'opcoes') <> 'array' or jsonb_array_length(e -> 'opcoes') <> 5
                 or upper(coalesce(e ->> 'gabarito', '')) !~ '^([0-4]|[A-E])$') then raise exception 'QUESTAO_INVALIDA'; end if;
  delete from public.simulado_questoes where simulado_id = p_id;
  insert into public.simulado_questoes (simulado_id, ordem, materia, texto_base, enunciado, opcoes, gabarito, explicacao)
  select p_id, e.n, trim(e.v ->> 'materia'), nullif(trim(coalesce(e.v ->> 'texto_base', '')), ''), trim(e.v ->> 'enunciado'), e.v -> 'opcoes',
         case when upper(e.v ->> 'gabarito') ~ '^[A-E]$' then ascii(upper(e.v ->> 'gabarito')) - 65 else (e.v ->> 'gabarito')::int end,
         coalesce(trim(e.v ->> 'explicacao'), '')
    from jsonb_array_elements(p_lista) with ordinality e(v, n);
  get diagnostics n = row_count;
  return n;
end $$;

create or replace function public.admin_simulado_questoes(p_id bigint)
returns jsonb language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return (select coalesce(jsonb_agg(jsonb_build_object('ordem', q.ordem, 'materia', q.materia, 'texto_base', q.texto_base, 'enunciado', q.enunciado,
            'opcoes', q.opcoes, 'gabarito', q.gabarito, 'explicacao', q.explicacao) order by q.ordem), '[]'::jsonb)
          from public.simulado_questoes q where q.simulado_id = p_id);
end $$;

create or replace function public.admin_simulado_excluir(p_id bigint)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  if exists (select 1 from public.simulado_respostas r where r.simulado_id = p_id) then raise exception 'JA_INICIADO'; end if;
  delete from public.simulados where id = p_id;
end $$;

-- ============ permissões ============
revoke all on function public.sim_corrigir(bigint, uuid), public.sim_fechar_vencidos(bigint), public.sim_meu(bigint, uuid),
  public.sim_cabecalho(public.simulados) from public, anon, authenticated;
revoke all on function public.simulado_info(text), public.simulado_iniciar(bigint), public.simulado_salvar(bigint, jsonb),
  public.simulado_entregar(bigint, jsonb), public.simulado_resultado(bigint),
  public.admin_simulados(), public.admin_simulado_salvar(bigint, text, date, text, text, integer, boolean),
  public.admin_simulado_questoes_importar(bigint, jsonb), public.admin_simulado_questoes(bigint), public.admin_simulado_excluir(bigint) from public;
grant execute on function public.simulado_info(text) to anon, authenticated;
grant execute on function public.simulado_iniciar(bigint), public.simulado_salvar(bigint, jsonb), public.simulado_entregar(bigint, jsonb),
  public.simulado_resultado(bigint), public.admin_simulados(), public.admin_simulado_salvar(bigint, text, date, text, text, integer, boolean),
  public.admin_simulado_questoes_importar(bigint, jsonb), public.admin_simulado_questoes(bigint), public.admin_simulado_excluir(bigint) to authenticated;

select 'simulado de domingo pronto' as status, (select count(*) from public.simulados) as simulados;
