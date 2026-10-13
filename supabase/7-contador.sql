-- Aprenda se Divertindo · 7 · Contador de visitas e partidas sem cadastro
-- Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
-- "aparelho" é um código aleatório criado no navegador: não identifica a pessoa.

-- VISITAS: uma linha por aparelho por dia ------------------------------------
create table if not exists public.visitas (
  id         bigint generated always as identity primary key,
  aparelho   uuid not null,
  dia        date not null default ((now() at time zone 'America/Sao_Paulo')::date),
  logado     boolean not null default false,
  criado_em  timestamptz not null default now(),
  unique (aparelho, dia)
);
alter table public.visitas enable row level security;
drop policy if exists "registrar visita" on public.visitas;
create policy "registrar visita" on public.visitas
  for insert to anon, authenticated
  with check (dia = ((now() at time zone 'America/Sao_Paulo')::date));
grant insert on public.visitas to anon, authenticated;

-- PARTIDAS SEM CONTA ---------------------------------------------------------
create table if not exists public.partidas_anonimas (
  id             bigint generated always as identity primary key,
  aparelho       uuid not null,
  modo           text not null check (modo in ('classico', 'desafio')),
  trilha         text not null check (trilha in ('geral','policial','tribunais','fiscal','administrativa')),
  questao_final  smallint not null check (questao_final between 1 and 30),
  premio         integer  not null default 0 check (premio between 0 and 1000000),
  acertos        smallint not null check (acertos between 0 and 40),
  respondidas    smallint not null check (respondidas between 0 and 40 and acertos <= respondidas),
  tempo_seg      integer check (tempo_seg >= 0),
  dia            date not null default ((now() at time zone 'America/Sao_Paulo')::date),
  criado_em      timestamptz not null default now()
);
create index if not exists partidas_anonimas_dia on public.partidas_anonimas (dia);
alter table public.partidas_anonimas enable row level security;
drop policy if exists "registrar partida anonima" on public.partidas_anonimas;
create policy "registrar partida anonima" on public.partidas_anonimas
  for insert to anon, authenticated
  with check (dia = ((now() at time zone 'America/Sao_Paulo')::date));
grant insert on public.partidas_anonimas to anon, authenticated;

-- PAINEL: um resumo por dia (só você vê, pelo SQL Editor ou Table Editor) ----
create or replace view public.resumo_diario
with (security_invoker = true) as
select d.dia,
       coalesce(v.visitantes, 0)        as visitantes,
       coalesce(v.visitantes_logados,0) as visitantes_com_conta,
       coalesce(a.partidas, 0)          as partidas_sem_conta,
       coalesce(p.partidas, 0)          as partidas_com_conta,
       coalesce(p.jogadores, 0)         as jogadores_com_conta,
       coalesce(u.novas, 0)             as contas_novas
from (select dia from public.visitas
      union select dia from public.partidas_anonimas
      union select dia from public.partidas) d
left join (select dia, count(*) visitantes, count(*) filter (where logado) visitantes_logados
           from public.visitas group by dia) v using (dia)
left join (select dia, count(*) partidas from public.partidas_anonimas group by dia) a using (dia)
left join (select dia, count(*) partidas, count(distinct user_id) jogadores from public.partidas group by dia) p using (dia)
left join (select (created_at at time zone 'America/Sao_Paulo')::date dia, count(*) novas from auth.users group by 1) u using (dia)
order by d.dia desc;
revoke all on public.resumo_diario from anon, authenticated;

select * from public.resumo_diario limit 7;
