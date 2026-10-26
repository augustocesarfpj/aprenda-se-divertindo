-- Aprenda se Divertindo · 97 · Simulado do Fim de Semana
-- Rode depois do 96-cartoes-administrativa.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- O que muda:
--   • O simulado passa a ficar aberto no fim de semana inteiro: do sábado, 0h, ao domingo, 23h59 (horário de Brasília).
--     A data cadastrada continua sendo a do domingo; o sábado anterior abre junto.
--   • O resto não muda: uma tentativa por pessoa, exclusivo Premium, gabarito comentado na segunda, às 0h.
--   • Os simulados de Saúde e Enem de 25/10 (que ninguém começou) são remarcados para o fim de semana de 31/10 e 01/11.

-- início do fim de semana do simulado (sábado 0h, horário de Brasília)
create or replace function public.sim_inicio(p_data date)
returns timestamptz language sql immutable set search_path = '' as $$ select ((p_data - 1)::timestamp at time zone 'America/Sao_Paulo') $$;

-- o que mostrar na capa para uma trilha
create or replace function public.simulado_info(p_trilha text)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare hoje date := public.sim_hoje(); a public.simulados; p public.simulados; u public.simulados; uid uuid := auth.uid();
begin
  -- aberto: o domingo é hoje (domingo) ou amanhã (sábado)
  select * into a from public.simulados where trilha = p_trilha and publicado and data between hoje and hoje + 1 order by data limit 1;
  select * into p from public.simulados where trilha = p_trilha and publicado and data > hoje + 1 order by data limit 1;
  select * into u from public.simulados where trilha = p_trilha and publicado and data < hoje order by data desc limit 1;
  if a.id is not null then perform public.sim_fechar_vencidos(a.id); end if;
  if u.id is not null then perform public.sim_fechar_vencidos(u.id); end if;
  return jsonb_build_object(
    'agora', public.sim_agora(), 'hoje', hoje, 'domingo', extract(isodow from hoje) = 7,
    'fim_de_semana', extract(isodow from hoje) in (6, 7),
    'atual', case when a.id is null then null else public.sim_cabecalho(a) || jsonb_build_object('meu', public.sim_meu(a.id, uid),
       'inicio', public.sim_inicio(a.data),
       'participantes', (select count(*) from public.simulado_respostas r where r.simulado_id = a.id)) end,
    'proximo', case when p.id is null then null else public.sim_cabecalho(p) || jsonb_build_object('inicio', public.sim_inicio(p.data)) end,
    'ultimo', case when u.id is null then null else public.sim_cabecalho(u) || jsonb_build_object('meu', public.sim_meu(u.id, uid),
       'participantes', (select count(*) from public.simulado_respostas r where r.simulado_id = u.id and r.entregue_em is not null)) end);
end $$;

-- começar (ou continuar) a prova: aberto de sábado 0h a domingo 23h59
create or replace function public.simulado_iniciar(p_simulado bigint)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); s public.simulados; r public.simulado_respostas;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  select * into s from public.simulados where id = p_simulado and publicado;
  if s.id is null then raise exception 'NAO_ENCONTRADO'; end if;
  if public.sim_hoje() not between s.data - 1 and s.data then raise exception 'FECHADO'; end if;
  if not exists (select 1 from public.simulado_questoes q where q.simulado_id = s.id) then raise exception 'SEM_QUESTOES'; end if;
  if not exists (select 1 from public.simulado_respostas x where x.simulado_id = s.id and x.user_id = uid)
     and not public.eh_premium(uid) then raise exception 'PREMIUM'; end if;
  insert into public.simulado_respostas (simulado_id, user_id, iniciado_em) values (s.id, uid, public.sim_agora())
  on conflict do nothing;
  perform public.sim_fechar_vencidos(s.id);
  select * into r from public.simulado_respostas where simulado_id = s.id and user_id = uid;
  if r.entregue_em is not null then raise exception 'JA_ENTREGUE'; end if;
  return public.sim_cabecalho(s) || jsonb_build_object(
    'agora', public.sim_agora(), 'iniciado_em', r.iniciado_em,
    'prazo', public.sim_prazo(r.iniciado_em, s.duracao_min, s.data), 'respostas', r.respostas,
    'questoes', (select coalesce(jsonb_agg(jsonb_build_object('ordem', q.ordem, 'materia', q.materia, 'texto_base', q.texto_base,
                   'enunciado', q.enunciado, 'opcoes', q.opcoes) order by q.ordem), '[]'::jsonb)
                 from public.simulado_questoes q where q.simulado_id = s.id));
end $$;

revoke all on function public.sim_inicio(date) from public, anon, authenticated;
revoke all on function public.simulado_info(text), public.simulado_iniciar(bigint) from public;
grant execute on function public.simulado_info(text) to anon, authenticated;
grant execute on function public.simulado_iniciar(bigint) to authenticated;

-- remarca Saúde e Enem de 25/10 para o fim de semana de 31/10 e 01/11 (só se ninguém começou)
update public.simulados s set data = date '2026-11-01'
 where s.trilha in ('saude', 'enem') and s.data = date '2026-10-25'
   and not exists (select 1 from public.simulado_respostas r where r.simulado_id = s.id)
   and not exists (select 1 from public.simulados o where o.trilha = s.trilha and o.data = date '2026-11-01');

select s.trilha, s.data - 1 as abre_sabado, s.data as fecha_domingo, s.titulo, s.publicado,
       (select count(*) from public.simulado_questoes q where q.simulado_id = s.id) as questoes,
       (select count(*) from public.simulado_respostas r where r.simulado_id = s.id) as fizeram
  from public.simulados s where s.data >= date '2026-10-25' order by s.data, s.trilha;
