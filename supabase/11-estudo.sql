-- Aprenda se Divertindo · 11 · Módulo de estudo (cartões com repetição espaçada)
-- Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.

-- meta diária de cartões novos de cada jogador (10, 20 ou 30)
alter table public.perfis add column if not exists meta_estudo smallint not null default 10;
alter table public.perfis drop constraint if exists perfis_meta_estudo_check;
alter table public.perfis add constraint perfis_meta_estudo_check check (meta_estudo in (10, 20, 30));

-- um registro por jogador por questão estudada
create table if not exists public.estudo (
  user_id          uuid    not null default auth.uid() references auth.users (id) on delete cascade,
  questao_id       integer not null,
  caixa            smallint not null default 1 check (caixa between 1 and 6),  -- 6 = dominada
  vence            date    not null,                                          -- quando volta para revisão
  alerta           boolean not null default false,                            -- falsa certeza recente
  vistas           integer not null default 0,
  acertos          integer not null default 0,
  falsas_certezas  integer not null default 0,
  primeira_vez     date    not null default ((now() at time zone 'America/Sao_Paulo')::date),
  atualizado_em    timestamptz not null default now(),
  primary key (user_id, questao_id)
);
create index if not exists estudo_vence on public.estudo (user_id, vence);

alter table public.estudo enable row level security;
drop policy if exists "ver o próprio estudo" on public.estudo;
create policy "ver o próprio estudo" on public.estudo
  for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "criar o próprio estudo" on public.estudo;
create policy "criar o próprio estudo" on public.estudo
  for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "atualizar o próprio estudo" on public.estudo;
create policy "atualizar o próprio estudo" on public.estudo
  for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
drop policy if exists "apagar o próprio estudo" on public.estudo;
create policy "apagar o próprio estudo" on public.estudo
  for delete to authenticated using ((select auth.uid()) = user_id);
grant select, insert, update, delete on public.estudo to authenticated;

-- a exclusão de conta passa a apagar também o estudo
create or replace function public.excluir_minha_conta()
returns void language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid();
begin
  if uid is null then raise exception 'É preciso estar logado para excluir a conta.'; end if;
  delete from public.estudo   where user_id = uid;
  delete from public.partidas where user_id = uid;
  delete from public.perfis   where id = uid;
  delete from auth.users      where id = uid;
end $$;
revoke all on function public.excluir_minha_conta() from public, anon;
grant execute on function public.excluir_minha_conta() to authenticated;
