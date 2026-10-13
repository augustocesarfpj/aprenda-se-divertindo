-- Aprenda se Divertindo · 6 · Exclusão de conta pelo próprio jogador (LGPD)
-- Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.

-- Apaga a conta de quem está logado. O perfil, o progresso e as partidas
-- são apagados junto, porque as tabelas usam "on delete cascade".
create or replace function public.excluir_minha_conta()
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare uid uuid := auth.uid();
begin
  if uid is null then
    raise exception 'É preciso estar logado para excluir a conta.';
  end if;
  delete from public.partidas where user_id = uid;
  delete from public.perfis   where id = uid;
  delete from auth.users      where id = uid;
end $$;

revoke all on function public.excluir_minha_conta() from public, anon;
grant execute on function public.excluir_minha_conta() to authenticated;
