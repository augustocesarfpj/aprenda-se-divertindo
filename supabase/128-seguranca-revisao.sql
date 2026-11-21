-- Aprenda se Divertindo · 128 · Revisão de segurança (novembro/2026)
-- Rode depois do 127-leis-novas-2026.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- PARTE 1 · Trava do ranking mais firme
--   O tempo de jogo (tempo_seg) vem do aparelho e pode ser falsificado. Agora o banco também confere
--   o relógio dele: entre um resultado e o seguinte precisa ter passado tempo real suficiente para
--   as respostas (pelo menos 2 segundos por resposta). Partidas legítimas não são afetadas.
--
-- PARTE 2 · Relatório (só consulta, não altera nada)
--   Mostra numa tabela só o que merece atenção:
--   • tabelas do schema public sem RLS;
--   • funções "security definer" que qualquer visitante sem conta (anon) consegue chamar;
--   • tamanho do banco (o plano grátis do Supabase vai até 500 MB).
--   Funções esperadas para visitantes: plano_info, ver_convite, ver_campeonato e as do contador de visitas.

-- ============ PARTE 1 ============
create or replace function public.partida_plausivel()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  escada integer[] := array[1000,2000,3000,4000,5000,7000,10000,15000,20000,25000,30000,40000,50000,60000,75000,
    100000,125000,150000,200000,250000,300000,350000,400000,450000,500000,600000,700000,800000,900000,1000000];
  hoje integer;
  ult timestamptz;
begin
  if new.premio > escada[new.questao_final] then raise exception 'RESULTADO_INVALIDO'; end if;
  if new.premio = 1000000 and new.acertos < 30 then raise exception 'RESULTADO_INVALIDO'; end if;
  if new.respondidas > 0 and (new.tempo_seg is null or new.tempo_seg < new.respondidas * 2) then
    raise exception 'RESULTADO_INVALIDO';
  end if;
  -- relógio do servidor: o resultado anterior precisa ter sido salvo há tempo suficiente para estas respostas
  select max(criado_em) into ult from public.partidas
   where user_id = new.user_id and criado_em > now() - interval '3 hours';
  if ult is not null and new.respondidas > 0 and extract(epoch from (now() - ult)) < new.respondidas * 2 then
    raise exception 'RESULTADO_INVALIDO';
  end if;
  select count(*) into hoje from public.partidas where user_id = new.user_id and dia = new.dia;
  if hoje >= 80 then raise exception 'LIMITE_DIARIO'; end if;
  return new;
end $$;

drop trigger if exists partida_plausivel on public.partidas;
create trigger partida_plausivel before insert on public.partidas
  for each row execute function public.partida_plausivel();

revoke all on function public.partida_plausivel() from public, anon, authenticated;

-- ============ PARTE 2 · relatório ============
select 'tabela sem RLS' as tipo, c.relname::text as nome, 'ligar RLS' as o_que_fazer
  from pg_class c join pg_namespace n on n.oid = c.relnamespace
 where n.nspname = 'public' and c.relkind = 'r' and not c.relrowsecurity
union all
select 'função liberada para visitante (anon)', p.proname || '(' || pg_get_function_identity_arguments(p.oid) || ')',
       'conferir se visitante sem conta deve poder chamar'
  from pg_proc p join pg_namespace n on n.oid = p.pronamespace
 where n.nspname = 'public' and p.prosecdef and p.prokind = 'f'
   and has_function_privilege('anon', p.oid, 'execute')
union all
select 'tamanho do banco', pg_size_pretty(pg_database_size(current_database())), 'limite do plano grátis: 500 MB'
order by 1, 2;
