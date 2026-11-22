-- Aprenda se Divertindo · 131 · Fecha para visitantes sem conta as funções que só servem para quem está logado
-- Rode depois do 130-captcha-e-contador.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- O relatório do 128 mostrou funções que um visitante sem conta (anon) consegue chamar.
-- Nenhuma era brecha: as de administração já conferem se é administrador, e as de simulado exigem login.
-- Mesmo assim, é melhor fechar a porta (segunda camada de proteção). Quem está logado continua usando normalmente.
--
-- Continuam abertas para visitantes, de propósito: plano_info, ver_convite, ver_campeonato,
-- questoes_versao, questoes_inativas, cartoes_versao (o jogo funciona sem conta),
-- simulado_info (mostra o aviso do simulado) e reportar_erro (aceita aviso de erro sem conta, com limite diário).

do $$
declare f text;
begin
  foreach f in array array[
    'admin_cartao_ativar(integer, boolean)',
    'admin_cartao_salvar(integer, text, text, text)',
    'admin_erro_status(text, bigint, integer, text)',
    'admin_erros(text)',
    'admin_erros_abertos()',
    'admin_simulado_excluir(bigint)',
    'admin_simulado_questao_editar(bigint, integer, text, jsonb, integer, text)',
    'admin_simulado_questoes(bigint)',
    'admin_simulado_questoes_importar(bigint, jsonb)',
    'admin_simulado_ranking(bigint)',
    'admin_simulado_salvar(bigint, text, date, text, text, integer, boolean)',
    'admin_simulados()',
    'simulado_entregar(bigint, jsonb)',
    'simulado_iniciar(bigint)',
    'simulado_resultado(bigint)',
    'simulado_salvar(bigint, jsonb)'
  ] loop
    execute format('revoke execute on function public.%s from public, anon', f);
    execute format('grant execute on function public.%s to authenticated', f);
  end loop;
  -- criar_perfil só roda sozinha quando alguém cria conta (gatilho); ninguém precisa chamá-la
  revoke execute on function public.criar_perfil() from public, anon, authenticated;
end $$;

-- conferência: deve sobrar só a lista "de propósito" acima
select p.proname || '(' || pg_get_function_identity_arguments(p.oid) || ')' as ainda_aberta_para_visitante
  from pg_proc p join pg_namespace n on n.oid = p.pronamespace
 where n.nspname = 'public' and p.prosecdef and p.prokind = 'f'
   and has_function_privilege('anon', p.oid, 'execute')
 order by 1;
