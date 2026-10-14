-- Aprenda se Divertindo · 33 · Linha do tempo das disputas, placar e pontos de disputa
-- Rode depois do 32-disputas.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Pontos da semana: 1 por acerto nas partidas + 5 por vitória em disputa + 2 por empate
-- (contam as disputas criadas na semana, dentro do próprio ranking).

-- pontos com disputas
drop function if exists public.tabela_semana(uuid, integer);
drop function if exists public.campeoes_ranking(uuid);
drop function if exists public.ranking_pontos(uuid, timestamptz, timestamptz);
create function public.ranking_pontos(p_ranking uuid, p_ini timestamptz, p_fim timestamptz)
returns table (user_id uuid, pontos integer, partidas integer, acertos integer, respondidas integer, maior_premio integer,
               vitorias integer, empates integer, derrotas integer)
language sql stable security definer set search_path = '' as $$
  with p as (
    select m.user_id, count(x.id)::int as partidas, coalesce(sum(x.acertos), 0)::int as acertos,
           coalesce(sum(x.respondidas), 0)::int as respondidas, coalesce(max(x.premio), 0)::int as maior_premio
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
  select p.user_id, p.acertos + 5 * coalesce(d.v, 0) + 2 * coalesce(d.e, 0), p.partidas, p.acertos, p.respondidas, p.maior_premio,
         coalesce(d.v, 0), coalesce(d.e, 0), coalesce(d.l, 0)
  from p left join d on d.user_id = p.user_id;
$$;

create function public.tabela_semana(p_id uuid, p_semana integer default 0)
returns table (membro uuid, nome text, papel text, pontos integer, partidas integer, acertos integer,
               respondidas integer, maior_premio integer, vitorias integer, empates integer, derrotas integer,
               campeao boolean, sou_eu boolean)
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
         (topo > 0 and coalesce(a.pontos, 0) = topo),
         m.user_id = auth.uid()
  from public.ranking_membros m
  join public.ranking_pontos(p_id, ini, fim) x on x.user_id = m.user_id
  left join public.ranking_pontos(p_id, public.ranking_inicio_semana(p_semana + 1), ini) a on a.user_id = m.user_id
  left join public.perfis pf on pf.id = m.user_id
  where m.ranking_id = p_id
  order by x.pontos desc, x.vitorias desc,
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

-- placar geral entre duas pessoas (todas as disputas concluídas entre elas, em qualquer ranking)
create or replace function public.disputa_placar(p_a uuid, p_b uuid)
returns table (a integer, b integer, empates integer)
language sql stable security definer set search_path = '' as $$
  select count(*) filter (where public.disputa_vencedor(d) = p_a)::int,
         count(*) filter (where public.disputa_vencedor(d) = p_b)::int,
         count(*) filter (where public.disputa_vencedor(d) is null)::int
  from public.disputas d
  where ((d.desafiante = p_a and d.desafiado = p_b) or (d.desafiante = p_b and d.desafiado = p_a))
    and public.disputa_status(d) = 'concluida';
$$;

-- linha do tempo do ranking: disputas dos últimos 7 dias (o prêmio só aparece quando a disputa termina)
create or replace function public.feed_disputas(p_ranking uuid)
returns table (id uuid, desafiante uuid, desafiado uuid, nome_desafiante text, nome_desafiado text, trilha text,
               status text, criada_em timestamptz, expira_em timestamptz,
               premio_desafiante integer, premio_desafiado integer, vencedor text,
               placar_desafiante integer, placar_desafiado integer, placar_empates integer)
language plpgsql stable security definer set search_path = '' as $$
begin
  if public.ranking_meu_papel(p_ranking) is null then raise exception 'SEM_ACESSO'; end if;
  return query
  select d.id, d.desafiante, d.desafiado,
         coalesce(p1.nome, 'Jogador')::text, coalesce(p2.nome, 'Jogador')::text, d.trilha,
         public.disputa_status(d), d.criada_em, d.expira_em,
         case when public.disputa_status(d) = 'concluida' then d.d1_premio end,
         case when public.disputa_status(d) = 'concluida' then coalesce(d.d2_premio, 0) end,
         case when public.disputa_status(d) <> 'concluida' then null
              when public.disputa_vencedor(d) is null then 'empate'
              when public.disputa_vencedor(d) = d.desafiante then 'desafiante' else 'desafiado' end,
         pl.a, pl.b, pl.empates
  from public.disputas d
  left join public.perfis p1 on p1.id = d.desafiante
  left join public.perfis p2 on p2.id = d.desafiado
  cross join lateral public.disputa_placar(d.desafiante, d.desafiado) pl
  where d.ranking_id = p_ranking and d.d1_fim is not null and d.criada_em > now() - interval '7 days'
  order by d.criada_em desc
  limit 30;
end $$;

-- minhas disputas agora informam o ranking e a outra pessoa (para o botão de revanche) e o placar entre os dois
drop function if exists public.minhas_disputas();
create function public.minhas_disputas()
returns table (id uuid, ranking text, outro text, sou_desafiante boolean, trilha text, horas integer, status text,
               expira_em timestamptz, criada_em timestamptz,
               meu_premio integer, meus_acertos integer, outro_premio integer, outro_acertos integer, resultado text,
               ranking_id uuid, outro_id uuid, placar_eu integer, placar_outro integer)
language sql stable security definer set search_path = '' as $$
  select d.id, r.nome, coalesce(pf.nome, 'Jogador')::text, d.desafiante = auth.uid(), d.trilha, d.horas::int,
         public.disputa_status(d), d.expira_em, d.criada_em,
         case when d.desafiante = auth.uid() then d.d1_premio else d.d2_premio end,
         (case when d.desafiante = auth.uid() then d.d1_acertos else d.d2_acertos end)::int,
         case when public.disputa_status(d) = 'concluida' then case when d.desafiante = auth.uid() then d.d2_premio else d.d1_premio end end,
         (case when public.disputa_status(d) = 'concluida' then case when d.desafiante = auth.uid() then d.d2_acertos else d.d1_acertos end end)::int,
         case when public.disputa_status(d) <> 'concluida' then null
              when public.disputa_vencedor(d) is null then 'empate'
              when public.disputa_vencedor(d) = auth.uid() then 'venci' else 'perdi' end,
         d.ranking_id,
         case when d.desafiante = auth.uid() then d.desafiado else d.desafiante end,
         pl.a, pl.b
  from public.disputas d
  join public.rankings r on r.id = d.ranking_id
  left join public.perfis pf on pf.id = case when d.desafiante = auth.uid() then d.desafiado else d.desafiante end
  cross join lateral public.disputa_placar(auth.uid(), case when d.desafiante = auth.uid() then d.desafiado else d.desafiante end) pl
  where (d.desafiante = auth.uid() or (d.desafiado = auth.uid() and d.d1_fim is not null))
    and (public.disputa_status(d) in ('preparando','aguardando','jogando') or d.criada_em > now() - interval '48 hours')
  order by d.criada_em desc
  limit 20;
$$;

revoke all on function public.ranking_pontos(uuid, timestamptz, timestamptz), public.disputa_placar(uuid, uuid) from public, anon, authenticated;
revoke all on function public.tabela_semana(uuid, integer), public.campeoes_ranking(uuid), public.feed_disputas(uuid),
  public.minhas_disputas() from public, anon;
grant execute on function public.tabela_semana(uuid, integer), public.campeoes_ranking(uuid), public.feed_disputas(uuid),
  public.minhas_disputas() to authenticated;

select 'placar das disputas pronto' as status;
