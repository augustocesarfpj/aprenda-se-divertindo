-- Aprenda se Divertindo · 113 · Campeonatos: pontos corridos e copa mata-mata
-- Rode depois do 112-campeonatos.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- RODADA ÚNICA (pode ter link de convite e/ou membros do ranking): uma prova só, com prazo de 1, 3 ou 7 dias. Vence o maior
--   prêmio; empate: acertos e depois tempo.
-- PONTOS CORRIDOS (pode ter link de convite e/ou membros do ranking): 1, 3, 5 ou 7 rodadas, uma por dia (24 h cada).
--   Em cada rodada todos jogam as mesmas questões. Pontos por rodada: 1º 10, 2º 8, 3º 6, 4º 5, 5º 4, 6º 3, 7º 2,
--   e 1 ponto para todos os outros que jogaram. Quem não joga a rodada fica com 0. Desempate: acertos e depois tempo.
-- COPA MATA-MATA (só membros do ranking, de 4 a 64 participantes): o sistema sorteia a chave. Se o número não for
--   4, 8, 16, 32 ou 64, alguns jogadores sorteados passam direto (folga). Cada fase dura 12 h, e a copa dura no mínimo
--   48 h (com poucas fases, cada uma fica mais longa). No confronto, vence o maior prêmio, depois mais acertos, depois
--   menor tempo. Quem não joga dentro do prazo perde por W.O.; se nenhum dos dois jogar, os dois saem.
-- Os campeonatos criados pelo 112 continuam funcionando como pontos corridos de 1 rodada.

-- relógio do campeonato (permite testar horários; em produção é sempre now())
create or replace function public.camp_agora()
returns timestamptz language sql stable set search_path = '' as $$
  select coalesce(nullif(current_setting('camp.agora', true), '')::timestamptz, now());
$$;

alter table public.campeonatos add column if not exists formato   text not null default 'pontos';
alter table public.campeonatos add column if not exists rodadas   smallint not null default 1;
alter table public.campeonatos add column if not exists dur_horas smallint;
alter table public.campeonatos add column if not exists chave     jsonb;
alter table public.campeonatos drop constraint if exists campeonatos_formato_check;
alter table public.campeonatos add constraint campeonatos_formato_check check (formato in ('pontos', 'mata'));
alter table public.campeonatos drop constraint if exists campeonatos_questoes_check;
alter table public.campeonatos add constraint campeonatos_questoes_check check (cardinality(questoes) between 30 and 2000);
update public.campeonatos set dur_horas = greatest(1, round(extract(epoch from fim - inicio) / 3600))::smallint where dur_horas is null;
alter table public.campeonatos alter column dur_horas set default 24;
alter table public.campeonatos alter column dur_horas set not null;

create table if not exists public.campeonato_jogos (
  campeonato_id uuid not null references public.campeonatos (id) on delete cascade,
  user_id       uuid not null references auth.users (id) on delete cascade,
  rodada        smallint not null,
  iniciado_em   timestamptz not null default now(),
  fim_em        timestamptz,
  premio        integer,
  nivel         smallint,
  acertos       smallint,
  respondidas   smallint,
  tempo         integer,
  primary key (campeonato_id, user_id, rodada)
);
alter table public.campeonato_jogos enable row level security;
revoke all on public.campeonato_jogos from anon, authenticated;

-- traz os resultados já gravados pelo 112 (rodada única)
insert into public.campeonato_jogos (campeonato_id, user_id, rodada, iniciado_em, fim_em, premio, nivel, acertos, respondidas, tempo)
select m.campeonato_id, m.user_id, 0, m.iniciado_em, m.fim_em, m.premio, m.nivel, m.acertos, m.respondidas, m.tempo
  from public.campeonato_membros m where m.iniciado_em is not null
on conflict do nothing;

-- rodada (ou fase) em andamento: 0, 1, 2...; null antes do início ou depois do fim
create or replace function public.camp_rodada(c public.campeonatos)
returns integer language sql stable set search_path = '' as $$
  select case when public.camp_agora() < c.inicio or public.camp_agora() >= c.fim then null
              else floor(extract(epoch from public.camp_agora() - c.inicio) / (c.dur_horas * 3600))::int end;
$$;

create or replace function public.camp_status(c public.campeonatos)
returns text language sql stable set search_path = '' as $$
  select case when public.camp_agora() < c.inicio then 'agendado' when public.camp_agora() < c.fim then 'aberto' else 'encerrado' end;
$$;

-- chave da copa calculada na hora: fases, confrontos, resultados e quem avançou.
-- Cada vaga é o id do jogador, '' (vaga vazia/folga) ou '?' (ainda a definir).
create or replace function public.camp_chave(p_id uuid)
returns jsonb language plpgsql stable security definer set search_path = '' as $$
declare c public.campeonatos; cur jsonb; nxt jsonb; fases jsonb := '[]'::jsonb; ms jsonb; f int; i int;
        a text; b text; w text; st text; ja public.campeonato_jogos; jb public.campeonato_jogos; prazo timestamptz; fa boolean; fb boolean;
begin
  select * into c from public.campeonatos where id = p_id;
  if c.id is null or c.formato <> 'mata' or c.chave is null then return null; end if;
  cur := c.chave;
  for f in 0 .. c.rodadas - 1 loop
    ms := '[]'::jsonb; nxt := '[]'::jsonb;
    prazo := c.inicio + make_interval(hours => (f + 1) * c.dur_horas);
    for i in 0 .. jsonb_array_length(cur) - 1 loop
      a := cur -> i ->> 0; b := cur -> i ->> 1;
      ja := null; jb := null; w := '?'; st := 'aguardando';
      if a = '?' or b = '?' then
        w := '?'; st := 'a definir';
      elsif a = '' and b = '' then
        w := ''; st := 'vazio';
      elsif a = '' or b = '' then
        w := coalesce(nullif(a, ''), b); st := 'folga';
      else
        select * into ja from public.campeonato_jogos where campeonato_id = p_id and user_id = a::uuid and rodada = f;
        select * into jb from public.campeonato_jogos where campeonato_id = p_id and user_id = b::uuid and rodada = f;
        fa := ja.fim_em is not null and ja.fim_em <= prazo + interval '45 minutes';
        fb := jb.fim_em is not null and jb.fim_em <= prazo + interval '45 minutes';
        if fa and fb then
          st := 'decidido';
          if (ja.premio, ja.acertos, -ja.tempo, -extract(epoch from ja.fim_em)) >= (jb.premio, jb.acertos, -jb.tempo, -extract(epoch from jb.fim_em))
          then w := a; else w := b; end if;
        elsif public.camp_agora() >= prazo + interval '45 minutes' then
          if fa then w := a; st := 'wo'; elsif fb then w := b; st := 'wo'; else w := ''; st := 'wo duplo'; end if;
        elsif public.camp_agora() < c.inicio + make_interval(hours => f * c.dur_horas) then
          st := 'aguardando';
        else
          st := 'em jogo';
        end if;
      end if;
      ms := ms || jsonb_build_array(jsonb_build_object(
        'a', a, 'b', b, 'vencedor', w, 'situacao', st,
        'na', (select coalesce(pf.nome, 'Jogador') from public.perfis pf where a not in ('', '?') and pf.id = a::uuid),
        'nb', (select coalesce(pf.nome, 'Jogador') from public.perfis pf where b not in ('', '?') and pf.id = b::uuid),
        'pa', case when ja.fim_em is not null then ja.premio end, 'pb', case when jb.fim_em is not null then jb.premio end,
        'aa', case when ja.fim_em is not null then ja.acertos end, 'ab', case when jb.fim_em is not null then jb.acertos end,
        'ta', case when ja.fim_em is not null then ja.tempo end, 'tb', case when jb.fim_em is not null then jb.tempo end,
        'ja', ja.iniciado_em is not null, 'jb', jb.iniciado_em is not null));
      if i % 2 = 0 then nxt := nxt || jsonb_build_array(jsonb_build_array(w)); else nxt := jsonb_set(nxt, array[(jsonb_array_length(nxt) - 1)::text], (nxt -> -1) || to_jsonb(w)); end if;
    end loop;
    fases := fases || jsonb_build_array(jsonb_build_object('fase', f,
      'inicio', c.inicio + make_interval(hours => f * c.dur_horas), 'fim', prazo, 'confrontos', ms));
    cur := nxt;
  end loop;
  return jsonb_build_object('fases', fases,
    'campeao', case when cur -> 0 ->> 0 not in ('', '?') then (select coalesce(pf.nome, 'Jogador') from public.perfis pf where pf.id = (cur -> 0 ->> 0)::uuid) end,
    'campeao_id', nullif(nullif(cur -> 0 ->> 0, ''), '?'));
end $$;

-- o que o participante pode fazer agora
create or replace function public.camp_minha_vez(c public.campeonatos, uid uuid)
returns text language plpgsql stable security definer set search_path = '' as $$
declare r int := public.camp_rodada(c); j public.campeonato_jogos; ch jsonb; m jsonb; op text;
begin
  if not exists (select 1 from public.campeonato_membros x where x.campeonato_id = c.id and x.user_id = uid) then return 'fora'; end if;
  if public.camp_agora() < c.inicio then return 'aguarde'; end if;
  if r is null then return 'encerrado'; end if;
  select * into j from public.campeonato_jogos where campeonato_id = c.id and user_id = uid and rodada = r;
  if j.fim_em is not null then return 'jogou'; end if;
  if j.iniciado_em is not null then return 'abandonou'; end if;
  if c.formato = 'pontos' then return 'sim'; end if;
  ch := public.camp_chave(c.id);
  for m in select * from jsonb_array_elements(ch -> 'fases' -> r -> 'confrontos') loop
    if m ->> 'a' = uid::text or m ->> 'b' = uid::text then
      op := case when m ->> 'a' = uid::text then m ->> 'b' else m ->> 'a' end;
      if op = '?' then return 'aguarde'; end if;
      if op = '' then return 'folga'; end if;
      return 'sim';
    end if;
  end loop;
  -- fora desta fase: ainda pode estar esperando um adversário a definir em fase anterior? (não: fases andam no relógio)
  return 'eliminado';
end $$;

-- criar (substitui a versão do 112)
drop function if exists public.criar_campeonato(text, text, text[], integer[], integer, uuid, uuid[], boolean);
drop function if exists public.criar_campeonato(text, text, text[], integer[], text, integer, uuid, uuid[], boolean);
create or replace function public.criar_campeonato(p_nome text, p_trilha text, p_materias text[], p_questoes integer[],
                                                   p_formato text, p_rodadas integer, p_ranking uuid default null,
                                                   p_convidados uuid[] default null, p_link boolean default true,
                                                   p_dias integer default 1)
returns json language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); v_id uuid; v_cod text; jog uuid[]; n int; tam int := 4; fases int := 2; dur int; pares jsonb := '[]'::jsonb;
        byes int; i int; lista uuid[];
begin
  if uid is null then raise exception 'LOGIN'; end if;
  if char_length(btrim(coalesce(p_nome, ''))) not between 3 and 50 then raise exception 'NOME_INVALIDO'; end if;
  if p_formato not in ('pontos', 'mata') then raise exception 'FORMATO_INVALIDO'; end if;
  if (select count(*) from public.campeonatos c where c.criador = uid and public.camp_agora() < c.fim) >= 3 then raise exception 'LIMITE_CAMPEONATOS'; end if;
  if p_ranking is not null and public.ranking_meu_papel(p_ranking) is null then raise exception 'SEM_ACESSO'; end if;
  if p_convidados is not null and cardinality(p_convidados) > 0 then
    if p_ranking is null then raise exception 'SEM_RANKING'; end if;
    if exists (select 1 from unnest(p_convidados) x
                where not exists (select 1 from public.ranking_membros m where m.ranking_id = p_ranking and m.user_id = x)) then
      raise exception 'NAO_MEMBRO';
    end if;
  end if;
  select array_agg(distinct x) into jog from unnest(coalesce(p_convidados, '{}'::uuid[]) || uid) x;
  n := cardinality(jog);

  if p_formato = 'pontos' then
    if p_rodadas not in (1, 3, 5, 7) then raise exception 'RODADAS_INVALIDAS'; end if;
    if not coalesce(p_link, false) and n < 2 then raise exception 'SEM_PARTICIPANTES'; end if;
    fases := p_rodadas; dur := 24;
    if p_rodadas = 1 then
      if p_dias not in (1, 3, 7) then raise exception 'PRAZO_INVALIDO'; end if;
      dur := p_dias * 24;   -- rodada única: prazo de 1, 3 ou 7 dias
    end if;
  else
    if p_ranking is null then raise exception 'SEM_RANKING'; end if;
    if n < 4 then raise exception 'POUCOS_JOGADORES'; end if;
    if n > 64 then raise exception 'MUITOS_JOGADORES'; end if;
    while tam < n loop tam := tam * 2; fases := fases + 1; end loop;
    dur := greatest(12, ceil(48.0 / fases))::int;
    -- sorteio: embaralha; os primeiros "byes" jogadores passam direto (folga); o resto se enfrenta
    select array_agg(x order by random()) into lista from unnest(jog) x;
    byes := tam - n;
    for i in 1 .. byes loop pares := pares || jsonb_build_array(jsonb_build_array(lista[i]::text, '')); end loop;
    i := byes + 1;
    while i <= n loop pares := pares || jsonb_build_array(jsonb_build_array(lista[i]::text, lista[i + 1]::text)); i := i + 2; end loop;
    select jsonb_agg(p order by random()) into pares from jsonb_array_elements(pares) p;
    p_link := false;
  end if;
  if cardinality(p_questoes) < 30 * fases then raise exception 'POUCAS_QUESTOES'; end if;

  loop
    v_cod := upper(substr(md5(random()::text || clock_timestamp()::text), 1, 7));
    exit when not exists (select 1 from public.campeonatos where codigo = v_cod);
  end loop;
  insert into public.campeonatos (codigo, nome, criador, ranking_id, trilha, materias, questoes, link_aberto, inicio, fim, formato, rodadas, dur_horas, chave)
  values (v_cod, btrim(p_nome), uid, p_ranking, p_trilha, p_materias, p_questoes, coalesce(p_link, true), public.camp_agora(),
          public.camp_agora() + make_interval(hours => fases * dur), p_formato, fases, dur, case when p_formato = 'mata' then pares end)
  returning id into v_id;
  insert into public.campeonato_membros (campeonato_id, user_id) select v_id, x from unnest(jog) x on conflict do nothing;
  return json_build_object('id', v_id, 'codigo', v_cod, 'fases', fases, 'dur_horas', dur, 'tamanho', case when p_formato = 'mata' then tam end);
end $$;

create or replace function public.ver_campeonato(p_codigo text)
returns json language sql stable security definer set search_path = '' as $$
  select json_build_object('id', c.id, 'nome', c.nome, 'trilha', c.trilha, 'materias', c.materias, 'fim', c.fim,
                           'formato', c.formato, 'rodadas', c.rodadas, 'dur_horas', c.dur_horas,
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
  if c.formato = 'mata' or not c.link_aberto then raise exception 'SO_CONVIDADOS'; end if;
  if public.camp_agora() >= c.fim then raise exception 'CAMP_ENCERRADO'; end if;
  if (select count(*) from public.campeonato_membros m where m.campeonato_id = c.id) >= 200 then raise exception 'CAMP_LOTADO'; end if;
  insert into public.campeonato_membros (campeonato_id, user_id) values (c.id, uid);
  return c.id;
end $$;

create or replace function public.meus_campeonatos()
returns json language sql stable security definer set search_path = '' as $$
  select coalesce(json_agg(x order by x.ordem, x.fim), '[]'::json) from (
    select c.id, c.codigo, c.nome, c.trilha, c.materias, c.fim, c.link_aberto, c.formato, c.rodadas, c.dur_horas,
           public.camp_status(c) as status, public.camp_rodada(c) as rodada,
           c.inicio + make_interval(hours => (coalesce(public.camp_rodada(c), 0) + 1) * c.dur_horas) as fim_rodada,
           public.camp_minha_vez(c, auth.uid()) as minha_vez,
           c.criador = auth.uid() as sou_criador,
           (select r.nome from public.rankings r where r.id = c.ranking_id) as ranking,
           (select count(*) from public.campeonato_membros m where m.campeonato_id = c.id) as participantes,
           (select count(*) from public.campeonato_jogos j where j.campeonato_id = c.id and j.rodada = public.camp_rodada(c) and j.fim_em is not null) as jogaram,
           case when c.formato = 'mata' and public.camp_agora() >= c.fim + interval '45 minutes' then public.camp_chave(c.id) ->> 'campeao' end as campeao,
           case when public.camp_status(c) = 'aberto' then 0 else 1 end as ordem
    from public.campeonato_membros me join public.campeonatos c on c.id = me.campeonato_id
    where me.user_id = auth.uid() and c.fim > public.camp_agora() - interval '7 days') x;
$$;

-- classificação: tabela de pontos (pontos corridos) ou chave (copa)
create or replace function public.classificacao_campeonato(p_id uuid)
returns json language plpgsql stable security definer set search_path = '' as $$
declare c public.campeonatos; tab json;
begin
  select * into c from public.campeonatos where id = p_id;
  if c.id is null or not exists (select 1 from public.campeonato_membros m where m.campeonato_id = p_id and m.user_id = auth.uid()) then
    raise exception 'SEM_ACESSO';
  end if;
  if c.formato = 'pontos' then
    with j as (select * from public.campeonato_jogos where campeonato_id = p_id and fim_em is not null),
         r as (select j.*, rank() over (partition by j.rodada order by j.premio desc, j.acertos desc, j.tempo) as pos from j),
         p as (select r.user_id, sum(case when r.pos <= 7 then (array[10,8,6,5,4,3,2])[r.pos] else 1 end) as pts,
                      count(*) as jogadas, sum(r.acertos) as acertos, sum(r.tempo) as tempo, max(r.premio) as melhor
                 from r group by r.user_id),
         t as (select coalesce(p.pts, 0) as pontos, coalesce(p.jogadas, 0) as jogadas, p.acertos, p.tempo, p.melhor,
                      coalesce(pf.nome, 'Jogador') as nome, m.user_id = auth.uid() as sou_eu,
                      (select case when jj.fim_em is not null then 'jogou' when jj.iniciado_em is not null then 'jogando' end
                         from public.campeonato_jogos jj where jj.campeonato_id = p_id and jj.user_id = m.user_id and jj.rodada = public.camp_rodada(c)) as rodada_atual
                 from public.campeonato_membros m left join p on p.user_id = m.user_id left join public.perfis pf on pf.id = m.user_id
                where m.campeonato_id = p_id)
    select json_agg(t2 order by t2.pos, t2.nome) into tab from (
      select rank() over (order by t.pontos desc, coalesce(t.acertos, 0) desc, t.tempo nulls last) as pos, t.* from t) t2;
  end if;
  return json_build_object('id', c.id, 'codigo', c.codigo, 'nome', c.nome, 'trilha', c.trilha, 'materias', c.materias, 'fim', c.fim,
    'formato', c.formato, 'rodadas', c.rodadas, 'dur_horas', c.dur_horas, 'rodada', public.camp_rodada(c),
    'status', public.camp_status(c), 'link_aberto', c.link_aberto, 'sou_criador', c.criador = auth.uid(),
    'minha_vez', public.camp_minha_vez(c, auth.uid()), 'eu', auth.uid(),
    'tabela', coalesce(tab, '[]'::json), 'chave', case when c.formato = 'mata' then public.camp_chave(c.id) end);
end $$;

-- começar a rodada/fase atual (uma vez só): devolve as questões dela
create or replace function public.iniciar_campeonato(p_id uuid)
returns json language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); c public.campeonatos; r int; v text; n int;
begin
  select * into c from public.campeonatos where id = p_id for update;
  if c.id is null then raise exception 'SEM_ACESSO'; end if;
  v := public.camp_minha_vez(c, uid);
  if v = 'fora' then raise exception 'SEM_ACESSO'; end if;
  if v = 'encerrado' then raise exception 'CAMP_ENCERRADO'; end if;
  if v in ('jogou', 'abandonou') then raise exception 'JA_JOGOU'; end if;
  if v = 'eliminado' then raise exception 'ELIMINADO'; end if;
  if v = 'folga' then raise exception 'FOLGA'; end if;
  if v = 'aguarde' then raise exception 'AGUARDE'; end if;
  r := public.camp_rodada(c);
  insert into public.campeonato_jogos (campeonato_id, user_id, rodada, iniciado_em) values (p_id, uid, r, public.camp_agora());
  update public.campeonato_membros set iniciado_em = coalesce(iniciado_em, public.camp_agora()) where campeonato_id = p_id and user_id = uid;
  n := cardinality(c.questoes) / c.rodadas;
  return json_build_object('id', c.id, 'nome', c.nome, 'trilha', c.trilha, 'materias', c.materias, 'rodada', r, 'rodadas', c.rodadas,
    'formato', c.formato, 'questoes', c.questoes[r * n + 1 : (r + 1) * n],
    'fim', c.inicio + make_interval(hours => (r + 1) * c.dur_horas));
end $$;

drop function if exists public.enviar_campeonato(uuid, integer, integer, integer, integer, integer);
create or replace function public.enviar_campeonato(p_id uuid, p_rodada integer, p_premio integer, p_nivel integer, p_acertos integer,
                                                    p_respondidas integer, p_tempo integer)
returns void language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); c public.campeonatos; j public.campeonato_jogos;
begin
  select * into c from public.campeonatos where id = p_id;
  select * into j from public.campeonato_jogos where campeonato_id = p_id and user_id = uid and rodada = p_rodada for update;
  if c.id is null or j.user_id is null then raise exception 'SEM_ACESSO'; end if;
  if p_premio not between 0 and 1000000 or p_nivel not between 1 and 30 or p_acertos not between 0 and 30
     or p_respondidas not between 0 and 30 or p_acertos > p_respondidas then raise exception 'RESULTADO_INVALIDO'; end if;
  if j.fim_em is not null or public.camp_agora() >= c.inicio + make_interval(hours => (p_rodada + 1) * c.dur_horas) + interval '45 minutes' then
    raise exception 'CAMP_FECHADO';
  end if;
  update public.campeonato_jogos set premio = p_premio, nivel = p_nivel, acertos = p_acertos, respondidas = p_respondidas,
         tempo = greatest(0, p_tempo), fim_em = public.camp_agora()
   where campeonato_id = p_id and user_id = uid and rodada = p_rodada;
end $$;

create or replace function public.sair_campeonato(p_id uuid)
returns void language plpgsql security definer set search_path = '' as $$
begin
  delete from public.campeonato_membros m using public.campeonatos c
   where m.campeonato_id = p_id and m.user_id = auth.uid() and c.id = m.campeonato_id and c.criador <> auth.uid()
     and c.formato = 'pontos'
     and not exists (select 1 from public.campeonato_jogos j where j.campeonato_id = p_id and j.user_id = auth.uid());
end $$;

revoke all on function public.camp_chave(uuid) from public, anon, authenticated;
revoke all on function public.camp_minha_vez(public.campeonatos, uuid) from public, anon, authenticated;
revoke all on function public.criar_campeonato(text, text, text[], integer[], text, integer, uuid, uuid[], boolean, integer) from public, anon;
revoke all on function public.enviar_campeonato(uuid, integer, integer, integer, integer, integer, integer) from public, anon;
grant execute on function public.criar_campeonato(text, text, text[], integer[], text, integer, uuid, uuid[], boolean, integer) to authenticated;
grant execute on function public.enviar_campeonato(uuid, integer, integer, integer, integer, integer, integer) to authenticated;
grant execute on function public.ver_campeonato(text) to anon, authenticated;
grant execute on function public.entrar_campeonato(text) to authenticated;
grant execute on function public.meus_campeonatos() to authenticated;
grant execute on function public.classificacao_campeonato(uuid) to authenticated;
grant execute on function public.iniciar_campeonato(uuid) to authenticated;
grant execute on function public.sair_campeonato(uuid) to authenticated;
