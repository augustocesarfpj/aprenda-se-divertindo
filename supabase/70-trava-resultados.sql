-- Aprenda se Divertindo · 70 · Trava contra resultados impossíveis no ranking
-- Rode depois do 69-versao-questoes.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
-- O banco passa a recusar partidas com prêmio acima do que a questão alcançada permite,
-- rápidas demais para o número de respostas, ou em quantidade absurda no mesmo dia.

create or replace function public.partida_plausivel()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  escada integer[] := array[1000,2000,3000,4000,5000,7000,10000,15000,20000,25000,30000,40000,50000,60000,75000,
    100000,125000,150000,200000,250000,300000,350000,400000,450000,500000,600000,700000,800000,900000,1000000];
  hoje integer;
begin
  if new.premio > escada[new.questao_final] then raise exception 'RESULTADO_INVALIDO'; end if;
  if new.premio = 1000000 and new.acertos < 30 then raise exception 'RESULTADO_INVALIDO'; end if;
  if new.respondidas > 0 and (new.tempo_seg is null or new.tempo_seg < new.respondidas * 2) then
    raise exception 'RESULTADO_INVALIDO';
  end if;
  select count(*) into hoje from public.partidas where user_id = new.user_id and dia = new.dia;
  if hoje >= 80 then raise exception 'LIMITE_DIARIO'; end if;
  return new;
end $$;

drop trigger if exists partida_plausivel on public.partidas;
create trigger partida_plausivel before insert on public.partidas
  for each row execute function public.partida_plausivel();
