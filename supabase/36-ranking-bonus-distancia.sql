-- Aprenda se Divertindo · 36 · Ranking: bônus para quem chega mais longe na prova
-- Rode depois do 35-disputas-ajuste.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Pontos da semana = 1 por acerto (como antes)
--                  + bônus de distância em cada prova (Show do Milhão e disputas), pelo número de questões vencidas:
--                      30 (R$ 1 milhão) → 100 · 29 → 75 · 28 → 65 · 27 → 55 · 26 → 45
--                      22 a 25 → 30 · 17 a 21 → 15 · 10 a 16 → 5 · 5 a 9 → 2 · até 4 → 0
--                  + 5 por vitória e 2 por empate em disputa (como antes).
-- O desafio do dia continua valendo só os acertos.
-- A tabela também passa a mostrar a questão mais longe que cada um alcançou na semana.

create or replace function public.bonus_distancia(p_vencidas integer)
returns integer language sql immutable set search_path = '' as $$
  select case
    when p_vencidas >= 30 then 100
    when p_vencidas = 29 then 75
    when p_vencidas = 28 then 65
    when p_vencidas = 27 then 55
    when p_vencidas = 26 then 45
    when p_vencidas >= 22 then 30
    when p_vencidas >= 17 then 15
    when p_vencidas >= 10 then 5
    when p_vencidas >= 5 then 2
    else 0 end;
$$;

-- questões vencidas numa partida da prova (quem ganhou o milhão venceu as 30)
create or replace function public.partida_vencidas(p public.partidas)
returns integer language sql immutable set search_path = '' as $$
  select case when p.modo = 'desafio' then 0
              when p.premio >= 1000000 then 30
              else greatest(0, p.questao_final - 1) end;
$$;

drop function if exists public.tabela_semana(uuid, integer);
drop function if exists public.campeoes_ranking(uuid);
drop function if exists public.ranking_pontos(uuid, timestamptz, timestamptz);
create function public.ranking_pontos(p_ranking uuid, p_ini timestamptz, p_fim timestamptz)
returns table (user_id uuid, pontos integer, partidas integer, acertos integer, respondidas integer, maior_premio integer,
               vitorias integer, empates integer, derrotas integer, bonus integer, mais_longe integer, milhoes integer)
language sql stable security definer set search_path = '' as $$
  with p as (
    select m.user_id, count(x.id)::int as partidas, coalesce(sum(x.acertos), 0)::int as acertos,
           coalesce(sum(x.respondidas), 0)::int as respondidas, coalesce(max(x.premio), 0)::int as maior_premio,
           coalesce(sum(public.bonus_distancia(public.partida_vencidas(x))), 0)::int as bonus,
           coalesce(max(case when x.modo <> 'desafio' then least(30, case when x.premio >= 1000000 then 30 else x.questao_final end) end), 0)::int as mais_longe,
           count(*) filter (where x.premio >= 1000000)::int as milhoes
    from public.ranking_membros m
    left join public.partidas x on x.user_id = m.user_id and x.criado_em >= p_ini and x.criado_em < p_fim
    where m.ranking_id = p_ranking group by m.user_id
  ), d as (
    select m.user_id,
           count(*) filter (where public.disputa_vencedor(z) = m.user_id)::int as v,
           count(*) filter (where public.disputa_vencedor(z) is null)::int as e,
           count(*) filter (where public.disputa_vencedor(z) is not null and public.disputa_vencedor(z) <> m.user_id)::int as l
    from public.ranking_membros m
    join public.disputas z on z.ranking_id = p_ranking and (z.desafiante = m.user_id or z.desafiado = m.user_id)
      and z.criada_em >= p_ini and z.criada_em < p_fim and public.disputa_status(z) = 'concluida'
    where m.ranking_id = p_ranking group by m.user_id
  )
  select p.user_id, p.acertos + p.bonus + 5 * coalesce(d.v, 0) + 2 * coalesce(d.e, 0), p.partidas, p.acertos, p.respondidas, p.maior_premio,
         coalesce(d.v, 0), coalesce(d.e, 0), coalesce(d.l, 0), p.bonus, p.mais_longe, p.milhoes
  from p left join d on d.user_id = p.user_id;
$$;

create function public.tabela_semana(p_id uuid, p_semana integer default 0)
returns table (membro uuid, nome text, papel text, pontos integer, partidas integer, acertos integer,
               respondidas integer, maior_premio integer, vitorias integer, empates integer, derrotas integer,
               bonus integer, mais_longe integer, milhoes integer, campeao boolean, sou_eu boolean)
language plpgsql stable security definer set search_path = '' as $$
declare ini timestamptz; fim timestamptz; topo integer;
begin
  if public.ranking_meu_papel(p_id) is null then raise exception 'SEM_ACESSO'; end if;
  p_semana := greatest(0, least(coalesce(p_semana, 0), 52));
  ini := public.ranking_inicio_semana(p_semana);
  fim := public.ranking_inicio_semana(p_semana - 1);
  select max(x.pontos) into topo
    from public.ranking_pontos(p_id, public.ranking_inicio_semana(p_semana + 1), ini) x;
  return query
  select m.user_id, coalesce(pf.nome, 'Jogador')::text, m.papel,
         x.pontos, x.partidas, x.acertos, x.respondidas, x.maior_premio, x.vitorias, x.empates, x.derrotas,
         x.bonus, x.mais_longe, x.milhoes,
         (topo > 0 and coalesce(a.pontos, 0) = topo),
         m.user_id = auth.uid()
  from public.ranking_membros m
  join public.ranking_pontos(p_id, ini, fim) x on x.user_id = m.user_id
  left join public.ranking_pontos(p_id, public.ranking_inicio_semana(p_semana + 1), ini) a on a.user_id = m.user_id
  left join public.perfis pf on pf.id = m.user_id
  where m.ranking_id = p_id
  order by x.pontos desc, x.mais_longe desc, x.vitorias desc,
           (case when x.respondidas > 0 then x.acertos::numeric / x.respondidas else 0 end) desc,
           x.partidas desc, m.entrou_em;
end $$;

create function public.campeoes_ranking(p_id uuid)
returns table (semana date, nome text, pontos integer)
language plpgsql stable security definer set search_path = '' as $$
declare criado timestamptz; k integer;
begin
  if public.ranking_meu_papel(p_id) is null then raise exception 'SEM_ACESSO'; end if;
  select r.criado_em into criado from public.rankings r where r.id = p_id;
  for k in 1..8 loop
    exit when public.ranking_inicio_semana(k - 1) <= criado;
    return query
      select (public.ranking_inicio_semana(k) at time zone 'America/Sao_Paulo')::date,
             coalesce(pf.nome, 'Jogador')::text, x.pontos
      from public.ranking_pontos(p_id, public.ranking_inicio_semana(k), public.ranking_inicio_semana(k - 1)) x
      left join public.perfis pf on pf.id = x.user_id
      where x.pontos > 0
        and x.pontos = (select max(y.pontos) from public.ranking_pontos(p_id, public.ranking_inicio_semana(k), public.ranking_inicio_semana(k - 1)) y);
  end loop;
end $$;

revoke all on function public.ranking_pontos(uuid, timestamptz, timestamptz) from public, anon, authenticated;
revoke all on function public.tabela_semana(uuid, integer), public.campeoes_ranking(uuid) from public, anon;
grant execute on function public.tabela_semana(uuid, integer), public.campeoes_ranking(uuid) to authenticated;

select 'bônus de distância pronto' as status;
