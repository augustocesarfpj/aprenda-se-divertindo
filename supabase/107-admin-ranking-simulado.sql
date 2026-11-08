-- Aprenda se Divertindo · 107 · Ranking do simulado na administração
-- Rode depois do 106-pagbank-pix-automatico.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
-- Só administradores enxergam: posição, nome, e-mail, acertos, tempo e quem começou sem entregar.

create or replace function public.admin_simulado_ranking(p_id bigint)
returns json language plpgsql stable security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return coalesce((select json_agg(x) from (
    select case when r.entregue_em is not null
                then rank() over (partition by (r.entregue_em is not null) order by r.acertos desc nulls last, r.tempo_seg nulls last) end as pos,
           coalesce(nullif(trim(pf.nome), ''), 'Jogador') as nome, u.email,
           r.acertos, r.total, r.tempo_seg, r.iniciado_em, r.entregue_em
    from public.simulado_respostas r
    left join auth.users u on u.id = r.user_id
    left join public.perfis pf on pf.id = r.user_id
    where r.simulado_id = p_id
    order by (r.entregue_em is null), r.acertos desc nulls last, r.tempo_seg nulls last, r.iniciado_em) x), '[]'::json);
end $$;
