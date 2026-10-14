-- Aprenda se Divertindo · trocar a senha de um jogador (quando ele pedir por e-mail)
-- 1) Troque os dois textos entre aspas simples abaixo:
--    o e-mail da conta do jogador e uma senha provisória (mínimo 6 caracteres).
-- 2) Cole tudo no SQL Editor do Supabase e clique em Run.
-- 3) Responda o e-mail do jogador com a senha provisória.
--    Ele entra no jogo e troca em Conta → Trocar senha.

update auth.users
set encrypted_password = extensions.crypt('SENHA_PROVISORIA', extensions.gen_salt('bf')),
    updated_at = now()
where email = lower('EMAIL_DO_JOGADOR');

-- deve mostrar 1 linha; se não mostrar nada, o e-mail não tem conta
select email, updated_at as senha_trocada_em
from auth.users
where email = lower('EMAIL_DO_JOGADOR');
