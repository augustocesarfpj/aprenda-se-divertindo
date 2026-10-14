-- Aprenda se Divertindo · 32 · Disputas entre membros do ranking (Show do Milhão)
-- Rode depois do 31-ranking-cargos-semana.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Quem desafia escolhe a trilha e o prazo (5 ou 24 horas) e joga primeiro.
-- O desafiado só vê a disputa depois disso, e joga exatamente as mesmas questões.
-- Se o prazo acabar sem o desafiado jogar, a disputa é cancelada sozinha (não precisa de rotina agendada).
-- Quem começa a jogar e abandona fica com R$ 0.

-- as partidas de disputa também entram no histórico (e na pontuação da semana)
alter table public.partidas drop constraint if exists partidas_modo_check;
alter table public.partidas add constraint partidas_modo_check check (modo in ('classico','desafio','disputa'));

create table if not exists public.disputas (
  id           uuid primary key default gen_random_uuid(),
  ranking_id   uuid not null references public.rankings (id) on delete cascade,
  desafiante   uuid not null references auth.users (id) on delete cascade,
  desafiado    uuid not null references auth.users (id) on delete cascade,
  trilha       text not null check (trilha in ('geral','policial','tribunais','fiscal','enem','administrativa')),
  horas        smallint not null check (horas in (5, 24)),
  questoes     integer[] not null check (cardinality(questoes) between 30 and 200),
  criada_em    timestamptz not null default now(),
  expira_em    timestamptz not null,
  recusada_em  timestamptz,
  d1_premio integer, d1_nivel smallint, d1_acertos smallint, d1_respondidas smallint, d1_tempo integer, d1_fim timestamptz,
  d2_inicio timestamptz,
  d2_premio integer, d2_nivel smallint, d2_acertos smallint, d2_respondidas smallint, d2_tempo integer, d2_fim timestamptz,
  check (desafiante <> desafiado)
);
create index if not exists disputas_desafiante on public.disputas (desafiante, criada_em desc);
create index if not exists disputas_desafiado on public.disputas (desafiado, criada_em desc);
create index if not exists disputas_ranking on public.disputas (ranking_id, criada_em desc);
alter table public.disputas enable row level security;
revoke all on public.disputas from anon, authenticated;

-- situação de uma disputa
create or replace function public.disputa_status(d public.disputas)
returns text language sql stable set search_path = '' as $$
  select case
    when d.recusada_em is not null then 'recusada'
    when d.d2_fim is not null then 'concluida'
    when d.d2_inicio is not null and now() >= d.expira_em + interval '1 hour' then 'concluida'
    when d.d2_inicio is not null then 'jogando'
    when now() >= d.expira_em then 'expirada'
    when d.d1_fim is null then 'preparando'
    else 'aguardando' end;
$$;

-- quem venceu: maior prêmio; empate no prêmio → mais acertos → menos tempo
create or replace function public.disputa_vencedor(d public.disputas)
returns uuid language sql stable set search_path = '' as $$
  select case
    when public.disputa_status(d) <> 'concluida' then null
    when coalesce(d.d1_premio,0) <> coalesce(d.d2_premio,0) then case when coalesce(d.d1_premio,0) > coalesce(d.d2_premio,0) then d.desafiante else d.desafiado end
    when coalesce(d.d1_acertos,0) <> coalesce(d.d2_acertos,0) then case when coalesce(d.d1_acertos,0) > coalesce(d.d2_acertos,0) then d.desafiante else d.desafiado end
    when d.d2_fim is not null and coalesce(d.d1_tempo,0) <> coalesce(d.d2_tempo,0) then case when coalesce(d.d1_tempo,0) < coalesce(d.d2_tempo,0) then d.desafiante else d.desafiado end
    else null end;
$$;

-- criar uma disputa (quem desafia joga em seguida, com as questões enviadas)
create or replace function public.criar_disputa(p_ranking uuid, p_desafiado uuid, p_trilha text, p_horas integer, p_questoes integer[])
returns uuid language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); v_id uuid;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  if public.ranking_meu_papel(p_ranking) is null then raise exception 'SEM_ACESSO'; end if;
  if p_desafiado = uid then raise exception 'NAO_PODE_SI'; end if;
  if not exists (select 1 from public.ranking_membros where ranking_id = p_ranking and user_id = p_desafiado) then raise exception 'NAO_MEMBRO'; end if;
  if p_horas not in (5, 24) then raise exception 'PRAZO_INVALIDO'; end if;
  if (select count(*) from public.disputas d where d.desafiante = uid
        and public.disputa_status(d) in ('preparando','aguardando','jogando')) >= 3 then
    raise exception 'LIMITE_DISPUTAS';
  end if;
  if exists (select 1 from public.disputas d
              where ((d.desafiante = uid and d.desafiado = p_desafiado) or (d.desafiante = p_desafiado and d.desafiado = uid))
                and public.disputa_status(d) in ('preparando','aguardando','jogando')) then
    raise exception 'DISPUTA_ABERTA';
  end if;
  insert into public.disputas (ranking_id, desafiante, desafiado, trilha, horas, questoes, expira_em)
  values (p_ranking, uid, p_desafiado, p_trilha, p_horas, p_questoes, now() + make_interval(hours => p_horas))
  returning id into v_id;
  return v_id;
end $$;

-- o desafiado começa a jogar: recebe as questões e, a partir daqui, abandonar vale R$ 0
create or replace function public.iniciar_disputa(p_id uuid)
returns table (trilha text, questoes integer[])
language plpgsql security definer set search_path = '' as $$
declare d public.disputas;
begin
  select * into d from public.disputas where id = p_id for update;
  if d.id is null or d.desafiado <> auth.uid() then raise exception 'SEM_ACESSO'; end if;
  if public.disputa_status(d) <> 'aguardando' then raise exception 'DISPUTA_FECHADA'; end if;
  update public.disputas set d2_inicio = now(), d2_premio = 0, d2_nivel = 1, d2_acertos = 0, d2_respondidas = 0 where id = p_id;
  return query select d.trilha, d.questoes;
end $$;

-- enviar o resultado (vale para quem desafiou e para quem foi desafiado)
create or replace function public.enviar_disputa(p_id uuid, p_premio integer, p_nivel integer, p_acertos integer, p_respondidas integer, p_tempo integer)
returns void language plpgsql security definer set search_path = '' as $$
declare d public.disputas; uid uuid := auth.uid();
begin
  select * into d from public.disputas where id = p_id for update;
  if d.id is null then raise exception 'SEM_ACESSO'; end if;
  if p_premio not between 0 and 1000000 or p_nivel not between 1 and 30 or p_acertos not between 0 and 30
     or p_respondidas not between 0 and 30 or p_acertos > p_respondidas then raise exception 'RESULTADO_INVALIDO'; end if;
  if d.desafiante = uid then
    if d.d1_fim is not null or now() >= d.expira_em then raise exception 'DISPUTA_FECHADA'; end if;
    update public.disputas set d1_premio = p_premio, d1_nivel = p_nivel, d1_acertos = p_acertos,
      d1_respondidas = p_respondidas, d1_tempo = greatest(0, p_tempo), d1_fim = now() where id = p_id;
  elsif d.desafiado = uid then
    if d.d2_inicio is null or d.d2_fim is not null or now() >= d.expira_em + interval '1 hour' then raise exception 'DISPUTA_FECHADA'; end if;
    update public.disputas set d2_premio = p_premio, d2_nivel = p_nivel, d2_acertos = p_acertos,
      d2_respondidas = p_respondidas, d2_tempo = greatest(0, p_tempo), d2_fim = now() where id = p_id;
  else raise exception 'SEM_ACESSO'; end if;
end $$;

-- recusar (só o desafiado, antes de começar)
create or replace function public.recusar_disputa(p_id uuid)
returns void language plpgsql security definer set search_path = '' as $$
declare d public.disputas;
begin
  select * into d from public.disputas where id = p_id for update;
  if d.id is null or d.desafiado <> auth.uid() then raise exception 'SEM_ACESSO'; end if;
  if public.disputa_status(d) <> 'aguardando' then raise exception 'DISPUTA_FECHADA'; end if;
  update public.disputas set recusada_em = now() where id = p_id;
end $$;

-- disputas de quem está logado: abertas e as encerradas nas últimas 48 horas.
-- o resultado do outro só aparece quando a disputa termina.
create or replace function public.minhas_disputas()
returns table (id uuid, ranking text, outro text, sou_desafiante boolean, trilha text, horas integer, status text,
               expira_em timestamptz, criada_em timestamptz,
               meu_premio integer, meus_acertos integer, outro_premio integer, outro_acertos integer, resultado text)
language sql stable security definer set search_path = '' as $$
  select d.id, r.nome, coalesce(pf.nome, 'Jogador')::text, d.desafiante = auth.uid(), d.trilha, d.horas::int,
         public.disputa_status(d), d.expira_em, d.criada_em,
         case when d.desafiante = auth.uid() then d.d1_premio else d.d2_premio end,
         (case when d.desafiante = auth.uid() then d.d1_acertos else d.d2_acertos end)::int,
         case when public.disputa_status(d) = 'concluida' then case when d.desafiante = auth.uid() then d.d2_premio else d.d1_premio end end,
         (case when public.disputa_status(d) = 'concluida' then case when d.desafiante = auth.uid() then d.d2_acertos else d.d1_acertos end end)::int,
         case when public.disputa_status(d) <> 'concluida' then null
              when public.disputa_vencedor(d) is null then 'empate'
              when public.disputa_vencedor(d) = auth.uid() then 'venci' else 'perdi' end
  from public.disputas d
  join public.rankings r on r.id = d.ranking_id
  left join public.perfis pf on pf.id = case when d.desafiante = auth.uid() then d.desafiado else d.desafiante end
  where (d.desafiante = auth.uid() or (d.desafiado = auth.uid() and d.d1_fim is not null))
    and (public.disputa_status(d) in ('preparando','aguardando','jogando') or d.criada_em > now() - interval '48 hours')
  order by d.criada_em desc
  limit 20;
$$;

-- a exclusão de conta também apaga as disputas da pessoa
create or replace function public.excluir_minha_conta()
returns void language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid();
begin
  if uid is null then raise exception 'É preciso estar logado para excluir a conta.'; end if;
  perform public.ranking_passar_posse(uid);
  delete from public.disputas where desafiante = uid or desafiado = uid;
  delete from public.ranking_membros where user_id = uid;
  delete from public.estudo   where user_id = uid;
  delete from public.partidas where user_id = uid;
  delete from public.perfis   where id = uid;
  delete from auth.users      where id = uid;
end $$;

revoke all on function public.disputa_status(public.disputas), public.disputa_vencedor(public.disputas) from public, anon, authenticated;
revoke all on function public.criar_disputa(uuid, uuid, text, integer, integer[]), public.iniciar_disputa(uuid),
  public.enviar_disputa(uuid, integer, integer, integer, integer, integer), public.recusar_disputa(uuid),
  public.minhas_disputas(), public.excluir_minha_conta() from public, anon;
grant execute on function public.criar_disputa(uuid, uuid, text, integer, integer[]), public.iniciar_disputa(uuid),
  public.enviar_disputa(uuid, integer, integer, integer, integer, integer), public.recusar_disputa(uuid),
  public.minhas_disputas(), public.excluir_minha_conta() to authenticated;

select 'disputas prontas' as status;
