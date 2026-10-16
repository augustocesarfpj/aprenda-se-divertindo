-- Aprenda se Divertindo · 69 · Versão das questões (economia de tráfego)
-- Rode depois do 68-trilha-tribunais-extra.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- O jogo consulta esta "impressão digital" das questões ao abrir. Se nada mudou desde a última
-- visita do jogador, ele usa o que já tem guardado e não baixa as mais de 7 mil questões de novo.
-- Qualquer questão lançada, corrigida, ativada ou desativada pela administração muda a versão na hora.

create or replace function public.questoes_versao()
returns text language sql stable security definer set search_path = '' as $$
  select md5(coalesce(string_agg(md5(concat_ws('|', id, materia, nivel, enunciado, opcoes::text, explicacao, ativa)), '' order by id), ''))
  from public.questoes;
$$;

revoke all on function public.questoes_versao() from public;
grant execute on function public.questoes_versao() to anon, authenticated;

select public.questoes_versao() as versao_atual, count(*) as total_de_questoes from public.questoes;
