-- Aprenda se Divertindo · 132 · Situação de cada pessoa no ranking do simulado (página de administração)
-- Rode depois do 131-fechar-funcoes-visitante.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- O ranking do simulado no admin passa a mostrar a situação de cada pessoa:
--   • concluido  → entregou a prova (tocou em Entregar);
--   • abandonado → começou e não entregou: o tempo dela (ou o simulado) acabou e o sistema fechou a prova sozinho;
--   • fazendo    → começou e ainda está dentro do tempo.
-- Antes, quem abandonava e tinha a prova fechada pelo sistema aparecia igual a quem entregou.
-- Quem abandonou continua com a nota das questões que respondeu, mas fica depois de quem concluiu.

create or replace function public.admin_simulado_ranking(p_id bigint)
returns json language plpgsql security definer set search_path = '' as $$
declare s public.simulados;
begin
  perform public.admin_exigir();
  select * into s from public.simulados where id = p_id;
  if s.id is null then return '[]'::json; end if;
  perform public.sim_fechar_vencidos(p_id);   -- fecha agora quem estourou o prazo, para a lista ficar certa
  return coalesce((select json_agg(x) from (
    select case when y.situacao = 'concluido'
                then rank() over (partition by (y.situacao = 'concluido') order by y.acertos desc nulls last, y.tempo_seg nulls last) end as pos,
           y.nome, y.email, y.acertos, y.total, y.tempo_seg, y.iniciado_em, y.entregue_em, y.situacao
    from (
      select coalesce(nullif(trim(pf.nome), ''), 'Jogador') as nome, u.email,
             r.acertos, r.total, r.tempo_seg, r.iniciado_em, r.entregue_em,
             case when r.entregue_em is null then 'fazendo'
                  -- a correção automática grava a entrega exatamente no prazo; quem toca em Entregar entrega antes
                  when r.entregue_em >= public.sim_prazo(r.iniciado_em, s.duracao_min, s.data) then 'abandonado'
                  else 'concluido' end as situacao
      from public.simulado_respostas r
      left join auth.users u on u.id = r.user_id
      left join public.perfis pf on pf.id = r.user_id
      where r.simulado_id = p_id) y
    order by case y.situacao when 'concluido' then 0 when 'abandonado' then 1 else 2 end,
             y.acertos desc nulls last, y.tempo_seg nulls last, y.iniciado_em) x), '[]'::json);
end $$;

revoke execute on function public.admin_simulado_ranking(bigint) from public, anon;
grant execute on function public.admin_simulado_ranking(bigint) to authenticated;

select 'ranking do simulado com a situação de cada pessoa' as status;
