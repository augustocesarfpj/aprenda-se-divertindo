-- Aprenda se Divertindo · 99 · Prorrogação do Simulado do Fim de Semana (feriados)
-- Rode depois do 98-simulado-policial-2.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- O que faz:
--   • Permite estender um fim de semana de simulado por mais dias (ex.: feriado na segunda).
--   • Já prorroga o fim de semana de 31/10–01/11/2026 até segunda, 02/11/2026 (Finados), às 23h59.
--   • O gabarito comentado passa a sair no dia seguinte ao último dia (neste caso, terça, 03/11, às 0h).
--   • Para prorrogar outro fim de semana no futuro:
--       insert into public.simulado_prorrogacoes (data, ate) values (date 'DOMINGO', date 'ÚLTIMO DIA')
--       on conflict (data) do update set ate = excluded.ate;

create table if not exists public.simulado_prorrogacoes (
  data date primary key check (extract(isodow from data) = 7),   -- o domingo do simulado
  ate  date not null,                                             -- último dia aberto (fecha às 23h59)
  check (ate >= data)
);
alter table public.simulado_prorrogacoes enable row level security;
revoke all on public.simulado_prorrogacoes from anon, authenticated;

insert into public.simulado_prorrogacoes (data, ate) values (date '2026-11-01', date '2026-11-02')
on conflict (data) do update set ate = excluded.ate;

-- último dia aberto do simulado daquele domingo
create or replace function public.sim_ate(p_data date)
returns date language sql stable security definer set search_path = '' as $$
  select coalesce((select x.ate from public.simulado_prorrogacoes x where x.data = p_data), p_data)
$$;

-- fim do simulado: 0h do dia seguinte ao último dia aberto (horário de Brasília)
create or replace function public.sim_fim(p_data date)
returns timestamptz language sql stable set search_path = '' as $$ select ((public.sim_ate(p_data) + 1)::timestamp at time zone 'America/Sao_Paulo') $$;

create or replace function public.sim_prazo(p_ini timestamptz, p_dur smallint, p_data date)
returns timestamptz language sql stable set search_path = '' as $$ select least(p_ini + make_interval(mins => p_dur), public.sim_fim(p_data)) $$;

-- o que mostrar na capa para uma trilha
create or replace function public.simulado_info(p_trilha text)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare hoje date := public.sim_hoje(); a public.simulados; p public.simulados; u public.simulados; uid uuid := auth.uid();
begin
  -- aberto: do sábado anterior até o último dia (domingo ou o dia da prorrogação)
  select * into a from public.simulados s where s.trilha = p_trilha and s.publicado
     and hoje between s.data - 1 and public.sim_ate(s.data) order by s.data limit 1;
  select * into p from public.simulados s where s.trilha = p_trilha and s.publicado and s.data - 1 > hoje order by s.data limit 1;
  select * into u from public.simulados s where s.trilha = p_trilha and s.publicado and public.sim_ate(s.data) < hoje order by s.data desc limit 1;
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

-- começar (ou continuar) a prova: do sábado 0h até o último dia, 23h59
create or replace function public.simulado_iniciar(p_simulado bigint)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); s public.simulados; r public.simulado_respostas;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  select * into s from public.simulados where id = p_simulado and publicado;
  if s.id is null then raise exception 'NAO_ENCONTRADO'; end if;
  if public.sim_hoje() not between s.data - 1 and public.sim_ate(s.data) then raise exception 'FECHADO'; end if;
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

revoke all on function public.sim_ate(date) from public, anon, authenticated;
revoke all on function public.simulado_info(text), public.simulado_iniciar(bigint) from public;
grant execute on function public.simulado_info(text) to anon, authenticated;
grant execute on function public.simulado_iniciar(bigint) to authenticated;

select s.trilha, s.titulo, s.data - 1 as abre, public.sim_ate(s.data) as ultimo_dia,
       public.sim_fim(s.data) at time zone 'America/Sao_Paulo' as fecha_e_libera_gabarito
  from public.simulados s where s.data = date '2026-11-01' order by s.trilha;
