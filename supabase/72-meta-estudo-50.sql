-- Aprenda se Divertindo · 72 · Meta de estudo de até 50 cartões novos por dia
-- Rode depois do 71-admin-trocar-senha.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Libera a opção "Maratona · 50" no módulo de estudo (antes eram 10, 20 ou 30 cartões novos por dia).

alter table public.perfis drop constraint if exists perfis_meta_estudo_check;
alter table public.perfis add constraint perfis_meta_estudo_check check (meta_estudo in (10, 20, 30, 50));

select 'meta de estudo até 50 liberada' as status;
