-- Aprenda se Divertindo · 129 · Limites do plano grátis conferidos pelo banco
-- Rode depois do 128-seguranca-revisao.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Até aqui, as 5 provas e os 5 cartões de estudo por dia do plano grátis eram contados só no aparelho.
-- Quem mexesse no código do site conseguia passar do limite. Agora o banco também confere:
--   • provas: quem não é Premium não grava mais que o limite de provas clássicas no dia (horário de Brasília);
--   • cartões: quem não é Premium não grava mais que o limite de cartões diferentes no dia.
--     A hora do cartão passa a ser sempre a do servidor (antes vinha do aparelho).
-- Só vale com a cobrança ligada (config "cobranca"), igual ao site. Premium continua sem limite.
-- Os limites são os mesmos da página de administração (config "limites").

create or replace function public.plano_livre(p_user uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select not coalesce((public.cfg('cobranca')->>'ativa')::boolean, false) or public.eh_premium(p_user);
$$;

-- provas
create or replace function public.partida_limite_plano()
returns trigger language plpgsql security definer set search_path = '' as $$
declare lim integer; feitas integer;
begin
  if new.modo <> 'classico' or public.plano_livre(new.user_id) then return new; end if;
  lim := coalesce((public.cfg('limites')->>'provas')::int, 5);
  select count(*) into feitas from public.partidas
   where user_id = new.user_id and modo = 'classico'
     and (criado_em at time zone 'America/Sao_Paulo')::date = public.plano_hoje();
  if feitas >= lim then raise exception 'LIMITE_PLANO'; end if;
  return new;
end $$;

drop trigger if exists partida_limite_plano on public.partidas;
create trigger partida_limite_plano before insert on public.partidas
  for each row execute function public.partida_limite_plano();

-- cartões de estudo
create or replace function public.estudo_limite_plano()
returns trigger language plpgsql security definer set search_path = '' as $$
declare lim integer; feitos integer;
begin
  new.atualizado_em := now();
  if public.plano_livre(new.user_id) then return new; end if;
  -- cartão que já contou hoje pode ser revisto à vontade
  if exists (select 1 from public.estudo e where e.user_id = new.user_id and e.questao_id = new.questao_id
               and (e.atualizado_em at time zone 'America/Sao_Paulo')::date = public.plano_hoje()) then
    return new;
  end if;
  lim := coalesce((public.cfg('limites')->>'cartoes')::int, 5);
  select count(*) into feitos from public.estudo e
   where e.user_id = new.user_id and (e.atualizado_em at time zone 'America/Sao_Paulo')::date = public.plano_hoje();
  if feitos >= lim then raise exception 'LIMITE_PLANO'; end if;
  return new;
end $$;

drop trigger if exists estudo_limite_plano on public.estudo;
create trigger estudo_limite_plano before insert or update on public.estudo
  for each row execute function public.estudo_limite_plano();

revoke all on function public.plano_livre(uuid), public.partida_limite_plano(), public.estudo_limite_plano()
  from public, anon, authenticated;

select 'limites do plano grátis conferidos pelo banco' as status,
       public.cfg('limites') as limites,
       coalesce((public.cfg('cobranca')->>'ativa')::boolean, false) as cobranca_ligada;
