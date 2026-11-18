-- Aprenda se Divertindo · Consulta: o Simulado Desafio está no banco?
-- Só consulta, não altera nada. Cole no SQL Editor e clique em Run.

select public.sim_hoje() as hoje_no_banco;

select s.id, s.trilha, s.data - 1 as abre, s.data as fecha, s.publicado, s.titulo,
       (select count(*) from public.simulado_questoes q where q.simulado_id = s.id) as questoes
  from public.simulados s
 where s.data >= date '2026-11-15'
 order by s.data, s.trilha;

select conname as trava, pg_get_constraintdef(oid) as regra
  from pg_constraint
 where conrelid = 'public.simulados'::regclass and contype = 'c';
