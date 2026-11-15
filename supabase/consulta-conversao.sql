-- Aprenda se Divertindo · Consulta: jogadores sem conta e quantos criaram conta depois
-- Só consulta, não altera nada. Cole no SQL Editor e clique em Run.
-- Conta por aparelho (código aleatório do navegador). Quem joga sem conta e cria a conta
-- no MESMO dia ainda não aparece como convertido (só a partir da próxima visita logado).

with ap as (
  select aparelho,
         min(dia) filter (where not logado) as primeiro_dia_sem_conta,
         min(dia) filter (where logado)     as primeiro_dia_com_conta
  from public.visitas
  where dia > (now() at time zone 'America/Sao_Paulo')::date - 30
  group by aparelho
),
pa as (
  select aparelho, count(*) as partidas
  from public.partidas_anonimas
  where dia > (now() at time zone 'America/Sao_Paulo')::date - 30
  group by aparelho
),
base as (
  select ap.*, coalesce(pa.partidas, 0) as partidas_sem_conta,
         (ap.primeiro_dia_com_conta > ap.primeiro_dia_sem_conta) as converteu
  from ap left join pa using (aparelho)
  where ap.primeiro_dia_sem_conta is not null
)
select 'Últimos 30 dias' as periodo,
       count(*)                                              as aparelhos_sem_conta,
       count(*) filter (where partidas_sem_conta > 0)        as jogaram_sem_conta,
       count(*) filter (where partidas_sem_conta = 0)        as so_olharam,
       count(*) filter (where partidas_sem_conta >= 2)       as bateram_limite_2_partidas,
       count(*) filter (where converteu)                     as criaram_conta_depois,
       round(100.0 * count(*) filter (where converteu) / nullif(count(*), 0), 1) as conversao_pct,
       round(100.0 * count(*) filter (where converteu and partidas_sem_conta > 0)
             / nullif(count(*) filter (where partidas_sem_conta > 0), 0), 1)     as conversao_de_quem_jogou_pct
from base;
