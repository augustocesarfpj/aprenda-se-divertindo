-- Aprenda se Divertindo · 71 · Trocar senha de jogador pela administração
-- Rode depois do 70-trava-resultados.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Cria o quadro "Senha de jogador" na aba Configurações do admin.html: você digita o e-mail
-- da conta e uma senha provisória, e o jogador entra com ela e troca em Conta → Trocar senha.
-- Só administradores conseguem usar. Por segurança, não troca a senha de outro administrador.

create or replace function public.admin_trocar_senha(p_email text, p_senha text)
returns text language plpgsql security definer set search_path = '' as $$
declare uid uuid; em text;
begin
  perform public.admin_exigir();
  if p_senha is null or length(p_senha) < 6 or length(p_senha) > 72 then raise exception 'SENHA_INVALIDA'; end if;
  select id, email into uid, em from auth.users where lower(email) = lower(trim(p_email));
  if uid is null then raise exception 'USUARIO_NAO_ENCONTRADO'; end if;
  if uid <> auth.uid() and exists (select 1 from public.admins a where a.user_id = uid) then raise exception 'NAO_PODE_ADMIN'; end if;
  update auth.users
     set encrypted_password = extensions.crypt(p_senha, extensions.gen_salt('bf')),
         updated_at = now()
   where id = uid;
  return em;
end $$;

revoke all on function public.admin_trocar_senha(text, text) from public, anon;
grant execute on function public.admin_trocar_senha(text, text) to authenticated;

select 'troca de senha pela administração pronta' as status;
