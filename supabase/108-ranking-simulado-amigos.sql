-- Aprenda se Divertindo · 108 · Simulado no ranking de amigos
-- Rode depois do 107-admin-ranking-simulado.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
-- Cria a aba "Simulado" em cada ranking de amigos: compara a % de acertos de quem ENTREGOU o simulado do fim de semana
-- (cada um na sua trilha). Não soma pontos ao ranking da semana. Só membros do ranking veem; e-mail nunca aparece.

create or replace function public.tabela_simulado(p_id uuid, p_data date default null)
returns json language plpgsql stable security definer set search_path = '' as $$
declare d date; datas json; linhas json;
begin
  if public.ranking_meu_papel(p_id) is null then raise exception 'SEM_ACESSO'; end if;

  -- fins de semana em que alguém do grupo entregou (mais recentes primeiro)
  select coalesce(json_agg(x.data order by x.data desc), '[]'::json) into datas from (
    select distinct s.data from public.simulado_respostas r
    join public.simulados s on s.id = r.simulado_id
    join public.ranking_membros m on m.user_id = r.user_id and m.ranking_id = p_id
    where r.entregue_em is not null order by s.data desc limit 12) x;

  d := coalesce(p_data, (select (datas->>0)::date),
                (select max(s.data) from public.simulados s where s.publicado and s.data <= public.plano_hoje() + 6));

  -- cada pessoa entra com o melhor resultado dela naquele fim de semana
  select coalesce(json_agg(t order by t.pos, t.nome), '[]'::json) into linhas from (
    select rank() over (order by b.pct desc, b.tempo_seg nulls last) as pos, b.*
    from (select distinct on (r.user_id)
                 r.user_id as membro, coalesce(pf.nome, 'Jogador') as nome, m.papel, s.trilha, s.titulo,
                 r.acertos, r.total, round(100.0 * r.acertos / nullif(r.total, 0), 1) as pct, r.tempo_seg,
                 r.user_id = auth.uid() as sou_eu
          from public.simulado_respostas r
          join public.simulados s on s.id = r.simulado_id and s.data = d
          join public.ranking_membros m on m.user_id = r.user_id and m.ranking_id = p_id
          left join public.perfis pf on pf.id = r.user_id
          where r.entregue_em is not null and r.total > 0
          order by r.user_id, (1.0 * r.acertos / r.total) desc, r.tempo_seg nulls last) b) t;

  return json_build_object('data', d, 'datas', datas, 'linhas', linhas,
    'aberto', exists (select 1 from public.simulados s where s.data = d and s.publicado and now() < public.sim_fim(s.data)));
end $$;

revoke all on function public.tabela_simulado(uuid, date) from public, anon;
grant execute on function public.tabela_simulado(uuid, date) to authenticated;
