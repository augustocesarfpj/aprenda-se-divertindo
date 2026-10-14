-- Aprenda se Divertindo · Liberar Premium depois do Pix
-- 1) Troque o e-mail abaixo pelo e-mail da conta de quem pagou.
-- 2) Clique em Run. Se a pessoa ainda tiver Premium ativo, os 6 meses são somados ao que falta.

with u as (select id from auth.users where lower(email) = lower('EMAIL-DA-PESSOA@exemplo.com'))
insert into public.assinaturas (user_id, ate, origem)
select u.id, now() + interval '6 months', 'pix' from u
on conflict (user_id) do update
  set ate = greatest(public.assinaturas.ate, now()) + interval '6 months', origem = 'pix', atualizado_em = now();

-- confira: deve aparecer o e-mail com a nova data de validade
select u.email, a.ate as premium_ate, a.origem
from public.assinaturas a join auth.users u on u.id = a.user_id
order by a.atualizado_em desc limit 5;
