-- Aprenda se Divertindo · 112 · Campeonatos
-- Rode depois do 111-repete-simulados-15-nov.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Qualquer jogador com conta cria um campeonato: escolhe nome, trilha, as matérias e o prazo (1, 3 ou 7 dias).
-- Participantes: membros de um ranking escolhidos por quem cria e/ou quem abrir o link de convite (se o link estiver liberado).
-- Todos jogam o Show do Milhão com as MESMAS questões, uma única vez. Classificação: maior prêmio, depois mais acertos,
-- depois menor tempo. Quem começa e abandona fica com R$ 0. Não soma pontos no ranking da semana.

create table if not exists public.campeonatos (
  id          uuid primary key default gen_random_uuid(),
  codigo      text not null unique,
  nome        text not null check (char_length(btrim(nome)) between 3 and 50),
  criador     uuid not null references auth.users (id) on delete cascade,
  ranking_id  uuid references public.rankings (id) on delete set null,
  trilha      text not null check (trilha in ('geral','policial','tribunais','fiscal','saude','enem','administrativa')),
  materias    text[] not null check (cardinality(materias) between 1 and 40),
  questoes    integer[] not null check (cardinality(questoes) between 30 and 200),
  link_aberto boolean not null default true,
  inicio      timestamptz not null default now(),
  fim         timestamptz not null,
  criado_em   timestamptz not null default now()
);
create index if not exists campeonatos_criador on public.campeonatos (criador, criado_em desc);

create table if not exists public.campeonato_membros (
  campeonato_id uuid not null references public.campeonatos (id) on delete cascade,
  user_id       uuid not null references auth.users (id) on delete cascade,
  entrou_em     timestamptz not null default now(),
  iniciado_em   timestamptz,
  fim_em        timestamptz,
  premio        integer,
  nivel         smallint,
  acertos       smallint,
  respondidas   smallint,
  tempo         integer,
  primary key (campeonato_id, user_id)
);
create index if not exists campeonato_membros_user on public.campeonato_membros (user_id);

alter table public.campeonatos enable row level security;
alter table public.campeonato_membros enable row level security;
revoke all on public.campeonatos from anon, authenticated;
revoke all on public.campeonato_membros from anon, authenticated;

create or replace function public.camp_status(c public.campeonatos)
returns text language sql stable set search_path = '' as $$
  select case when now() < c.inicio then 'agendado' when now() < c.fim then 'aberto' else 'encerrado' end;
$$;

-- criar
create or replace function public.criar_campeonato(p_nome text, p_trilha text, p_materias text[], p_questoes integer[],
                                                   p_dias integer, p_ranking uuid default null, p_convidados uuid[] default null,
                                                   p_link boolean default true)
returns json language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); v_id uuid; v_cod text; n int := 0;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  if char_length(btrim(coalesce(p_nome, ''))) not between 3 and 50 then raise exception 'NOME_INVALIDO'; end if;
  if p_dias not in (1, 3, 7) then raise exception 'PRAZO_INVALIDO'; end if;
  if (select count(*) from public.campeonatos c where c.criador = uid and now() < c.fim) >= 3 then raise exception 'LIMITE_CAMPEONATOS'; end if;
  if p_ranking is not null and public.ranking_meu_papel(p_ranking) is null then raise exception 'SEM_ACESSO'; end if;
  if p_convidados is not null and cardinality(p_convidados) > 0 then
    if p_ranking is null then raise exception 'SEM_RANKING'; end if;
    if exists (select 1 from unnest(p_convidados) x
                where not exists (select 1 from public.ranking_membros m where m.ranking_id = p_ranking and m.user_id = x)) then
      raise exception 'NAO_MEMBRO';
    end if;
  end if;
  if not coalesce(p_link, false) and coalesce(cardinality(p_convidados), 0) = 0 then raise exception 'SEM_PARTICIPANTES'; end if;
  loop
    v_cod := upper(substr(md5(random()::text || clock_timestamp()::text), 1, 7));
    exit when not exists (select 1 from public.campeonatos where codigo = v_cod);
  end loop;
  insert into public.campeonatos (codigo, nome, criador, ranking_id, trilha, materias, questoes, link_aberto, fim)
  values (v_cod, btrim(p_nome), uid, p_ranking, p_trilha, p_materias, p_questoes, coalesce(p_link, true), now() + make_interval(days => p_dias))
  returning id into v_id;
  insert into public.campeonato_membros (campeonato_id, user_id) values (v_id, uid);
  if p_convidados is not null then
    insert into public.campeonato_membros (campeonato_id, user_id)
    select v_id, x from (select distinct unnest(p_convidados) x) y where x <> uid
    on conflict do nothing;
  end if;
  return json_build_object('id', v_id, 'codigo', v_cod);
end $$;

-- informações para quem abre o link (não exige ser membro)
create or replace function public.ver_campeonato(p_codigo text)
returns json language sql stable security definer set search_path = '' as $$
  select json_build_object('id', c.id, 'nome', c.nome, 'trilha', c.trilha, 'materias', c.materias, 'fim', c.fim,
                           'status', public.camp_status(c), 'link_aberto', c.link_aberto,
                           'criador', coalesce((select pf.nome from public.perfis pf where pf.id = c.criador), 'Jogador'),
                           'participantes', (select count(*) from public.campeonato_membros m where m.campeonato_id = c.id),
                           'sou_membro', exists (select 1 from public.campeonato_membros m where m.campeonato_id = c.id and m.user_id = auth.uid()))
  from public.campeonatos c where c.codigo = upper(btrim(p_codigo));
$$;

create or replace function public.entrar_campeonato(p_codigo text)
returns uuid language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); c public.campeonatos;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  select * into c from public.campeonatos where codigo = upper(btrim(p_codigo));
  if c.id is null then raise exception 'NAO_ENCONTRADO'; end if;
  if exists (select 1 from public.campeonato_membros m where m.campeonato_id = c.id and m.user_id = uid) then return c.id; end if;
  if not c.link_aberto then raise exception 'SO_CONVIDADOS'; end if;
  if now() >= c.fim then raise exception 'CAMP_ENCERRADO'; end if;
  if (select count(*) from public.campeonato_membros m where m.campeonato_id = c.id) >= 200 then raise exception 'CAMP_LOTADO'; end if;
  insert into public.campeonato_membros (campeonato_id, user_id) values (c.id, uid);
  return c.id;
end $$;

-- campeonatos de quem está logado (abertos e encerrados nos últimos 7 dias)
create or replace function public.meus_campeonatos()
returns json language sql stable security definer set search_path = '' as $$
  select coalesce(json_agg(x order by x.ordem, x.fim), '[]'::json) from (
    select c.id, c.codigo, c.nome, c.trilha, c.materias, c.fim, c.link_aberto, public.camp_status(c) as status,
           c.criador = auth.uid() as sou_criador,
           (select r.nome from public.rankings r where r.id = c.ranking_id) as ranking,
           (select count(*) from public.campeonato_membros m where m.campeonato_id = c.id) as participantes,
           (select count(*) from public.campeonato_membros m where m.campeonato_id = c.id and m.fim_em is not null) as jogaram,
           me.iniciado_em is not null as comecei, me.fim_em is not null as terminei, me.premio as meu_premio,
           case when public.camp_status(c) = 'aberto' then 0 else 1 end as ordem
    from public.campeonato_membros me join public.campeonatos c on c.id = me.campeonato_id
    where me.user_id = auth.uid() and c.fim > now() - interval '7 days') x;
$$;

-- classificação (só participantes). Quem começou e não terminou aparece com R$ 0 depois do fim.
create or replace function public.classificacao_campeonato(p_id uuid)
returns json language plpgsql stable security definer set search_path = '' as $$
declare c public.campeonatos;
begin
  select * into c from public.campeonatos where id = p_id;
  if c.id is null or not exists (select 1 from public.campeonato_membros m where m.campeonato_id = p_id and m.user_id = auth.uid()) then
    raise exception 'SEM_ACESSO';
  end if;
  return json_build_object('id', c.id, 'codigo', c.codigo, 'nome', c.nome, 'trilha', c.trilha, 'materias', c.materias, 'fim', c.fim,
    'status', public.camp_status(c), 'link_aberto', c.link_aberto, 'sou_criador', c.criador = auth.uid(),
    'linhas', coalesce((select json_agg(t order by t.pos nulls last, t.nome) from (
      select case when m.fim_em is not null or (m.iniciado_em is not null and now() >= c.fim)
                  then rank() over (partition by (m.fim_em is not null or (m.iniciado_em is not null and now() >= c.fim))
                                    order by coalesce(m.premio, 0) desc, coalesce(m.acertos, 0) desc, m.tempo nulls last) end as pos,
             coalesce(pf.nome, 'Jogador') as nome, m.user_id = auth.uid() as sou_eu,
             case when m.fim_em is not null then 'terminou' when m.iniciado_em is not null and now() >= c.fim then 'abandonou'
                  when m.iniciado_em is not null then 'jogando' else 'pendente' end as situacao,
             case when m.fim_em is not null then m.premio when m.iniciado_em is not null and now() >= c.fim then 0 end as premio,
             case when m.fim_em is not null then m.acertos end as acertos,
             case when m.fim_em is not null then m.tempo end as tempo
      from public.campeonato_membros m left join public.perfis pf on pf.id = m.user_id
      where m.campeonato_id = p_id) t), '[]'::json));
end $$;

-- começar (uma vez só): devolve as questões
create or replace function public.iniciar_campeonato(p_id uuid)
returns json language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); c public.campeonatos; m public.campeonato_membros;
begin
  select * into c from public.campeonatos where id = p_id;
  select * into m from public.campeonato_membros where campeonato_id = p_id and user_id = uid for update;
  if c.id is null or m.user_id is null then raise exception 'SEM_ACESSO'; end if;
  if now() >= c.fim then raise exception 'CAMP_ENCERRADO'; end if;
  if m.iniciado_em is not null then raise exception 'JA_JOGOU'; end if;
  update public.campeonato_membros set iniciado_em = now() where campeonato_id = p_id and user_id = uid;
  return json_build_object('id', c.id, 'nome', c.nome, 'trilha', c.trilha, 'materias', c.materias, 'questoes', c.questoes, 'fim', c.fim);
end $$;

create or replace function public.enviar_campeonato(p_id uuid, p_premio integer, p_nivel integer, p_acertos integer, p_respondidas integer, p_tempo integer)
returns void language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); c public.campeonatos; m public.campeonato_membros;
begin
  select * into c from public.campeonatos where id = p_id;
  select * into m from public.campeonato_membros where campeonato_id = p_id and user_id = uid for update;
  if c.id is null or m.user_id is null then raise exception 'SEM_ACESSO'; end if;
  if p_premio not between 0 and 1000000 or p_nivel not between 1 and 30 or p_acertos not between 0 and 30
     or p_respondidas not between 0 and 30 or p_acertos > p_respondidas then raise exception 'RESULTADO_INVALIDO'; end if;
  if m.iniciado_em is null or m.fim_em is not null or now() >= c.fim + interval '1 hour' then raise exception 'CAMP_FECHADO'; end if;
  update public.campeonato_membros set premio = p_premio, nivel = p_nivel, acertos = p_acertos, respondidas = p_respondidas,
         tempo = greatest(0, p_tempo), fim_em = now()
   where campeonato_id = p_id and user_id = uid;
end $$;

-- quem criou pode apagar o campeonato
create or replace function public.excluir_campeonato(p_id uuid)
returns void language plpgsql security definer set search_path = '' as $$
begin
  if not exists (select 1 from public.campeonatos where id = p_id and criador = auth.uid()) then raise exception 'SEM_ACESSO'; end if;
  delete from public.campeonatos where id = p_id;
end $$;

-- sair de um campeonato antes de jogar
create or replace function public.sair_campeonato(p_id uuid)
returns void language plpgsql security definer set search_path = '' as $$
begin
  delete from public.campeonato_membros m using public.campeonatos c
   where m.campeonato_id = p_id and m.user_id = auth.uid() and c.id = m.campeonato_id and c.criador <> auth.uid() and m.iniciado_em is null;
end $$;

revoke all on function public.criar_campeonato(text, text, text[], integer[], integer, uuid, uuid[], boolean) from public, anon;
revoke all on function public.ver_campeonato(text) from public;
revoke all on function public.entrar_campeonato(text) from public, anon;
revoke all on function public.meus_campeonatos() from public, anon;
revoke all on function public.classificacao_campeonato(uuid) from public, anon;
revoke all on function public.iniciar_campeonato(uuid) from public, anon;
revoke all on function public.enviar_campeonato(uuid, integer, integer, integer, integer, integer) from public, anon;
revoke all on function public.excluir_campeonato(uuid) from public, anon;
revoke all on function public.sair_campeonato(uuid) from public, anon;
grant execute on function public.criar_campeonato(text, text, text[], integer[], integer, uuid, uuid[], boolean) to authenticated;
grant execute on function public.ver_campeonato(text) to anon, authenticated;
grant execute on function public.entrar_campeonato(text) to authenticated;
grant execute on function public.meus_campeonatos() to authenticated;
grant execute on function public.classificacao_campeonato(uuid) to authenticated;
grant execute on function public.iniciar_campeonato(uuid) to authenticated;
grant execute on function public.enviar_campeonato(uuid, integer, integer, integer, integer, integer) to authenticated;
grant execute on function public.excluir_campeonato(uuid) to authenticated;
grant execute on function public.sair_campeonato(uuid) to authenticated;
