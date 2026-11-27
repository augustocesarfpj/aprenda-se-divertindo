-- Aprenda se Divertindo · 135 · Inclui o e-mail do jogo nos e-mails de notificação
-- Rode depois do 134-emails-automaticos.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
-- Acrescenta aprendasedivertindo26@gmail.com à lista (mantém os que já estão). Essa lista recebe o resumo de avisos
-- dos e-mails automáticos e também os comprovantes de Pix que os jogadores mandam pelo botão "Enviar por e-mail".

update public.config
   set valor = valor || '["aprendasedivertindo26@gmail.com"]'::jsonb, atualizado_em = now()
 where chave = 'emails'
   and jsonb_typeof(valor) = 'array'
   and not valor ? 'aprendasedivertindo26@gmail.com';

select valor as emails_de_notificacao from public.config where chave = 'emails';
