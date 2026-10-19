-- Aprenda se Divertindo · 87 · Ranking mensal
-- Rode depois do 86-trilha-fiscal-extra-3.sql. Cole tudo no SQL Editor e clique em Run. Rodar de novo apenas atualiza.
-- Cria a tabela do mês (do dia 1º, 0h de Brasília, até agora), com a mesma pontuação da tabela semanal.

create or replace function public.ranking_inicio_mes(p_offset integer default 0)
returns timestamptz language sql stable set search_path = '' as $$
  select (date_trunc('month', now() at time zone 'America/Sao_Paulo') - make_interval(months => p_offset)) at time zone 'America/Sao_Paulo';
$$;

drop function if exists public.tabela_mes(uuid);
create function public.tabela_mes(p_id uuid)
returns table (membro uuid, nome text, papel text, pontos integer, partidas integer, acertos integer,
               respondidas integer, maior_premio integer, vitorias integer, empates integer, derrotas integer,
               bonus integer, mais_longe integer, milhoes integer, saque integer, campeao boolean, sou_eu boolean)
language plpgsql stable security definer set search_path = '' as $$
declare ini timestamptz; fim timestamptz; topo integer;
begin
  if public.ranking_meu_papel(p_id) is null then raise exception 'SEM_ACESSO'; end if;
  ini := public.ranking_inicio_mes(0);
  fim := public.ranking_inicio_mes(-1);
  -- a coroa continua sendo do campeão da semana passada, como na tabela semanal
  select max(x.pontos) into topo
    from public.ranking_pontos(p_id, public.ranking_inicio_semana(1), public.ranking_inicio_semana(0)) x;
  return query
  select m.user_id, coalesce(pf.nome, 'Jogador')::text, m.papel,
         x.pontos, x.partidas, x.acertos, x.respondidas, x.maior_premio, x.vitorias, x.empates, x.derrotas,
         x.bonus, x.mais_longe, x.milhoes, x.saque,
         (topo > 0 and coalesce(a.pontos, 0) = topo),
         m.user_id = auth.uid()
  from public.ranking_membros m
  join public.ranking_pontos(p_id, ini, fim) x on x.user_id = m.user_id
  left join public.ranking_pontos(p_id, public.ranking_inicio_semana(1), public.ranking_inicio_semana(0)) a on a.user_id = m.user_id
  left join public.perfis pf on pf.id = m.user_id
  where m.ranking_id = p_id
  order by x.pontos desc, x.mais_longe desc, x.vitorias desc,
           (case when x.respondidas > 0 then x.acertos::numeric / x.respondidas else 0 end) desc,
           x.partidas desc, m.entrou_em;
end $$;

revoke all on function public.tabela_mes(uuid), public.ranking_inicio_mes(integer) from public, anon;
grant execute on function public.tabela_mes(uuid) to authenticated;

select 'ranking mensal pronto' as status;
