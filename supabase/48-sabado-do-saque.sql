-- Aprenda se Divertindo · 48 · Sábado do Saque
-- Rode depois do 47-trilha-policial-3.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- O administrador ou um líder ativa o Sábado do Saque no ranking (Gerenciar).
-- Aos sábados, das 00h às 21h (horário de Brasília), cada um pode lançar um SAQUE: uma disputa valendo pontos do ranking.
--   · Só vale contra quem está até 3 posições ACIMA na tabela da semana.
--   · Aposta: 25 pontos (30 se o alvo for o 1º colocado).
--   · Desafiante vence → leva a aposta inteira do desafiado.
--   · Desafiado vence → leva metade da aposta (arredondada para cima) do desafiante.
--   · Empate → ninguém ganha nada.
--   · O desafiado tem até 3h30 (e no máximo até 23h59 do sábado) para jogar.
--   · Recusar: a primeira recusa do sábado é grátis (escudo 🛡️); as seguintes custam 10 pontos para quem desafiou.
--   · Deixar expirar sem jogar também custa 10 pontos para quem desafiou.
--   · Um saque por dupla no sábado e no máximo 3 saques recebidos por pessoa no sábado.
--   · Ninguém fica com pontos negativos na semana.
-- O "Saqueador do Sábado" é quem tiver o maior saldo de saques na semana.

alter table public.rankings add column if not exists saque boolean not null default false;
alter table public.disputas add column if not exists saque boolean not null default false;
alter table public.disputas add column if not exists valor smallint;
alter table public.disputas add column if not exists escudo boolean not null default false;
create index if not exists disputas_saque on public.disputas (desafiado, criada_em desc) where saque;

-- relógio do saque (separado para poder ser testado)
create or replace function public.saque_agora()
returns timestamptz language sql stable set search_path = '' as $$ select now() $$;

-- é sábado? e ainda dá para lançar saque (até 21h)?
create or replace function public.saque_sabado()
returns boolean language sql stable set search_path = '' as $$
  select extract(isodow from public.saque_agora() at time zone 'America/Sao_Paulo') = 6;
$$;
create or replace function public.saque_aberto()
returns boolean language sql stable set search_path = '' as $$
  select public.saque_sabado() and extract(hour from public.saque_agora() at time zone 'America/Sao_Paulo') < 21;
$$;

-- pontos que cada disputa de saque transfere (positivo para quem ganha, negativo para quem perde)
create or replace function public.saque_mov(d public.disputas)
returns table (user_id uuid, delta integer)
language sql stable set search_path = '' as $$
  with s as (select public.disputa_status(d) as st, public.disputa_vencedor(d) as v, coalesce(d.valor, 25)::int as val)
  select x.u, x.dl from s, lateral (values
    (d.desafiante, case when s.st = 'concluida' and s.v = d.desafiante then s.val
                        when s.st = 'concluida' and s.v = d.desafiado then -ceil(s.val / 2.0)::int
                        when s.st = 'recusada' and not d.escudo then 10
                        when s.st = 'expirada' and d.d1_fim is not null then 10 else 0 end),
    (d.desafiado,  case when s.st = 'concluida' and s.v = d.desafiante then -s.val
                        when s.st = 'concluida' and s.v = d.desafiado then ceil(s.val / 2.0)::int
                        when s.st = 'recusada' and not d.escudo then -10
                        when s.st = 'expirada' and d.d1_fim is not null then -10 else 0 end)
  ) x(u, dl)
  where d.saque;
$$;

-- pontos da semana, agora com o saldo de saques (e nunca negativos)
drop function if exists public.tabela_semana(uuid, integer);
drop function if exists public.campeoes_ranking(uuid);
drop function if exists public.ranking_pontos(uuid, timestamptz, timestamptz);
create function public.ranking_pontos(p_ranking uuid, p_ini timestamptz, p_fim timestamptz)
returns table (user_id uuid, pontos integer, partidas integer, acertos integer, respondidas integer, maior_premio integer,
               vitorias integer, empates integer, derrotas integer, bonus integer, mais_longe integer, milhoes integer, saque integer)
language sql stable security definer set search_path = '' as $$
  with p as (
    select m.user_id, count(x.id)::int as partidas, coalesce(sum(x.acertos), 0)::int as acertos,
           coalesce(sum(x.respondidas), 0)::int as respondidas, coalesce(max(x.premio), 0)::int as maior_premio,
           coalesce(sum(public.bonus_distancia(public.partida_vencidas(x))), 0)::int as bonus,
           coalesce(max(case when x.modo <> 'desafio' then least(30, case when x.premio >= 1000000 then 30 else x.questao_final end) end), 0)::int as mais_longe,
           count(*) filter (where x.premio >= 1000000)::int as milhoes
    from public.ranking_membros m
    left join public.partidas x on x.user_id = m.user_id and x.criado_em >= p_ini and x.criado_em < p_fim
    where m.ranking_id = p_ranking group by m.user_id
  ), d as (
    select m.user_id,
           count(*) filter (where public.disputa_vencedor(z) = m.user_id)::int as v,
           count(*) filter (where public.disputa_vencedor(z) is null)::int as e,
           count(*) filter (where public.disputa_vencedor(z) is not null and public.disputa_vencedor(z) <> m.user_id)::int as l
    from public.ranking_membros m
    join public.disputas z on z.ranking_id = p_ranking and (z.desafiante = m.user_id or z.desafiado = m.user_id)
      and z.criada_em >= p_ini and z.criada_em < p_fim and public.disputa_status(z) = 'concluida'
    where m.ranking_id = p_ranking group by m.user_id
  ), s as (
    select mv.user_id, sum(mv.delta)::int as saldo
    from public.disputas z
    cross join lateral public.saque_mov(z) mv
    where z.ranking_id = p_ranking and z.saque and z.criada_em >= p_ini and z.criada_em < p_fim
    group by mv.user_id
  )
  select p.user_id,
         greatest(0, p.acertos + p.bonus + 5 * coalesce(d.v, 0) + 2 * coalesce(d.e, 0) + coalesce(s.saldo, 0)),
         p.partidas, p.acertos, p.respondidas, p.maior_premio,
         coalesce(d.v, 0), coalesce(d.e, 0), coalesce(d.l, 0), p.bonus, p.mais_longe, p.milhoes, coalesce(s.saldo, 0)
  from p left join d on d.user_id = p.user_id left join s on s.user_id = p.user_id;
$$;

create function public.tabela_semana(p_id uuid, p_semana integer default 0)
returns table (membro uuid, nome text, papel text, pontos integer, partidas integer, acertos integer,
               respondidas integer, maior_premio integer, vitorias integer, empates integer, derrotas integer,
               bonus integer, mais_longe integer, milhoes integer, saque integer, campeao boolean, sou_eu boolean)
language plpgsql stable security definer set search_path = '' as $$
declare ini timestamptz; fim timestamptz; topo integer;
begin
  if public.ranking_meu_papel(p_id) is null then raise exception 'SEM_ACESSO'; end if;
  p_semana := greatest(0, least(coalesce(p_semana, 0), 52));
  ini := public.ranking_inicio_semana(p_semana);
  fim := public.ranking_inicio_semana(p_semana - 1);
  select max(x.pontos) into topo
    from public.ranking_pontos(p_id, public.ranking_inicio_semana(p_semana + 1), ini) x;
  return query
  select m.user_id, coalesce(pf.nome, 'Jogador')::text, m.papel,
         x.pontos, x.partidas, x.acertos, x.respondidas, x.maior_premio, x.vitorias, x.empates, x.derrotas,
         x.bonus, x.mais_longe, x.milhoes, x.saque,
         (topo > 0 and coalesce(a.pontos, 0) = topo),
         m.user_id = auth.uid()
  from public.ranking_membros m
  join public.ranking_pontos(p_id, ini, fim) x on x.user_id = m.user_id
  left join public.ranking_pontos(p_id, public.ranking_inicio_semana(p_semana + 1), ini) a on a.user_id = m.user_id
  left join public.perfis pf on pf.id = m.user_id
  where m.ranking_id = p_id
  order by x.pontos desc, x.mais_longe desc, x.vitorias desc,
           (case when x.respondidas > 0 then x.acertos::numeric / x.respondidas else 0 end) desc,
           x.partidas desc, m.entrou_em;
end $$;

create function public.campeoes_ranking(p_id uuid)
returns table (semana date, nome text, pontos integer)
language plpgsql stable security definer set search_path = '' as $$
declare criado timestamptz; k integer;
begin
  if public.ranking_meu_papel(p_id) is null then raise exception 'SEM_ACESSO'; end if;
  select r.criado_em into criado from public.rankings r where r.id = p_id;
  for k in 1..8 loop
    exit when public.ranking_inicio_semana(k - 1) <= criado;
    return query
      select (public.ranking_inicio_semana(k) at time zone 'America/Sao_Paulo')::date,
             coalesce(pf.nome, 'Jogador')::text, x.pontos
      from public.ranking_pontos(p_id, public.ranking_inicio_semana(k), public.ranking_inicio_semana(k - 1)) x
      left join public.perfis pf on pf.id = x.user_id
      where x.pontos > 0
        and x.pontos = (select max(y.pontos) from public.ranking_pontos(p_id, public.ranking_inicio_semana(k), public.ranking_inicio_semana(k - 1)) y);
  end loop;
end $$;

-- posição de cada um na tabela desta semana (mesma ordem da tabela)
create or replace function public.saque_posicoes(p_ranking uuid)
returns table (user_id uuid, pos integer, pontos integer)
language sql stable security definer set search_path = '' as $$
  select x.user_id,
         (row_number() over (order by x.pontos desc, x.mais_longe desc, x.vitorias desc,
            (case when x.respondidas > 0 then x.acertos::numeric / x.respondidas else 0 end) desc,
            x.partidas desc, m.entrou_em))::int,
         x.pontos
  from public.ranking_pontos(p_ranking, public.ranking_inicio_semana(0), public.ranking_inicio_semana(-1)) x
  join public.ranking_membros m on m.ranking_id = p_ranking and m.user_id = x.user_id;
$$;

-- saques recebidos por alguém neste sábado (os inacabados de quem desafiou deixam de contar depois de 1 hora)
create or replace function public.saque_recebidos(p_user uuid)
returns integer language sql stable security definer set search_path = '' as $$
  select count(*)::int from public.disputas d
  where d.saque and d.desafiado = p_user and d.criada_em > now() - interval '24 hours'
    and (d.d1_fim is not null or d.criada_em > now() - interval '1 hour');
$$;

-- o escudo (recusa grátis) ainda está disponível neste sábado?
create or replace function public.saque_escudo_livre(p_user uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select not exists (select 1 from public.disputas d
                     where d.saque and d.desafiado = p_user and d.escudo and d.criada_em > now() - interval '24 hours');
$$;

-- informações do saque para quem está vendo o ranking: está ativo, é sábado, quem pode ser saqueado e por quanto
create or replace function public.saque_info(p_ranking uuid)
returns json language plpgsql stable security definer set search_path = '' as $$
declare uid uuid := auth.uid(); ativo boolean; minha integer; alvos json;
begin
  if public.ranking_meu_papel(p_ranking) is null then raise exception 'SEM_ACESSO'; end if;
  select r.saque into ativo from public.rankings r where r.id = p_ranking;
  if not coalesce(ativo, false) then
    return json_build_object('ativo', false, 'sabado', public.saque_sabado(), 'aberto', false, 'alvos', '[]'::json,
                             'escudo', public.saque_escudo_livre(uid));
  end if;
  select p.pos into minha from public.saque_posicoes(p_ranking) p where p.user_id = uid;
  select coalesce(json_agg(json_build_object(
           'membro', p.user_id, 'pos', p.pos,
           'valor', case when p.pos = 1 then 30 else 25 end,
           'motivo', case
             when not public.saque_aberto() then 'FECHADO'
             when exists (select 1 from public.disputas d where d.saque and d.criada_em > now() - interval '24 hours'
                            and ((d.desafiante = uid and d.desafiado = p.user_id) or (d.desafiante = p.user_id and d.desafiado = uid))
                            and (d.d1_fim is not null or d.criada_em > now() - interval '1 hour')) then 'JA_SAQUEOU'
             when exists (select 1 from public.disputas d
                            where ((d.desafiante = uid and d.desafiado = p.user_id) or (d.desafiante = p.user_id and d.desafiado = uid))
                              and (public.disputa_status(d) in ('aguardando','jogando')
                                   or (public.disputa_status(d) = 'preparando' and d.criada_em > now() - interval '1 hour'))) then 'DISPUTA_ABERTA'
             when public.saque_recebidos(p.user_id) >= 3 then 'ALVO_PROTEGIDO'
             else null end
         ) order by p.pos), '[]'::json)
    into alvos
  from public.saque_posicoes(p_ranking) p
  where minha is not null and p.pos between minha - 3 and minha - 1;
  return json_build_object('ativo', true, 'sabado', public.saque_sabado(), 'aberto', public.saque_aberto(),
                           'minha_pos', minha, 'alvos', alvos, 'escudo', public.saque_escudo_livre(uid));
end $$;

-- administrador e líderes ativam ou desativam o Sábado do Saque
create or replace function public.definir_saque(p_ranking uuid, p_ativo boolean)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.ranking_exigir_gestor(p_ranking);
  update public.rankings set saque = coalesce(p_ativo, false) where id = p_ranking;
end $$;

-- lançar um saque (quem desafia joga em seguida, como numa disputa comum)
create or replace function public.criar_saque(p_ranking uuid, p_desafiado uuid, p_trilha text, p_questoes integer[])
returns json language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); v_id uuid; minha integer; dele integer; v_valor integer; v_exp timestamptz; fim timestamptz;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  if public.ranking_meu_papel(p_ranking) is null then raise exception 'SEM_ACESSO'; end if;
  if not coalesce((select r.saque from public.rankings r where r.id = p_ranking), false) then raise exception 'SAQUE_DESATIVADO'; end if;
  if not public.saque_aberto() then raise exception 'SAQUE_FECHADO'; end if;
  if p_desafiado = uid then raise exception 'NAO_PODE_SI'; end if;
  if not exists (select 1 from public.ranking_membros where ranking_id = p_ranking and user_id = p_desafiado) then raise exception 'NAO_MEMBRO'; end if;
  -- parte da própria pessoa que ficou inacabada (fechou o app, perdeu a conexão…): descarta
  delete from public.disputas d where d.desafiante = uid and d.d1_fim is null and d.recusada_em is null;
  select p.pos into minha from public.saque_posicoes(p_ranking) p where p.user_id = uid;
  select p.pos into dele  from public.saque_posicoes(p_ranking) p where p.user_id = p_desafiado;
  if minha is null or dele is null or dele >= minha or dele < minha - 3 then raise exception 'ALVO_FORA'; end if;
  if (select count(*) from public.disputas d where d.desafiante = uid
        and public.disputa_status(d) in ('preparando','aguardando','jogando')) >= 3 then
    raise exception 'LIMITE_DISPUTAS';
  end if;
  if exists (select 1 from public.disputas d
              where ((d.desafiante = uid and d.desafiado = p_desafiado) or (d.desafiante = p_desafiado and d.desafiado = uid))
                and (public.disputa_status(d) in ('aguardando','jogando')
                     or (public.disputa_status(d) = 'preparando' and d.criada_em > now() - interval '1 hour'))) then
    raise exception 'DISPUTA_ABERTA';
  end if;
  if exists (select 1 from public.disputas d where d.saque and d.criada_em > now() - interval '24 hours'
              and ((d.desafiante = uid and d.desafiado = p_desafiado) or (d.desafiante = p_desafiado and d.desafiado = uid))
              and (d.d1_fim is not null or d.criada_em > now() - interval '1 hour')) then
    raise exception 'JA_SAQUEOU';
  end if;
  if public.saque_recebidos(p_desafiado) >= 3 then raise exception 'ALVO_PROTEGIDO'; end if;
  v_valor := case when dele = 1 then 30 else 25 end;
  fim := (date_trunc('day', public.saque_agora() at time zone 'America/Sao_Paulo') + interval '1 day' - interval '1 second') at time zone 'America/Sao_Paulo';
  v_exp := least(now() + interval '3 hours 30 minutes', now() + (fim - public.saque_agora()));
  insert into public.disputas (ranking_id, desafiante, desafiado, trilha, horas, questoes, expira_em, saque, valor)
  values (p_ranking, uid, p_desafiado, p_trilha, 5, p_questoes, v_exp, true, v_valor)
  returning id into v_id;
  return json_build_object('id', v_id, 'expira_em', v_exp, 'valor', v_valor);
end $$;

-- recusar: no saque, a primeira recusa do sábado usa o escudo (não perde pontos)
create or replace function public.recusar_disputa(p_id uuid)
returns void language plpgsql security definer set search_path = '' as $$
declare d public.disputas;
begin
  select * into d from public.disputas where id = p_id for update;
  if d.id is null or d.desafiado <> auth.uid() then raise exception 'SEM_ACESSO'; end if;
  if public.disputa_status(d) <> 'aguardando' then raise exception 'DISPUTA_FECHADA'; end if;
  update public.disputas set recusada_em = now(),
         escudo = d.saque and public.saque_escudo_livre(d.desafiado)
   where id = p_id;
end $$;

-- linha do tempo: agora informa se a disputa é saque, quanto vale e se o escudo foi usado
drop function if exists public.feed_disputas(uuid);
create function public.feed_disputas(p_ranking uuid)
returns table (id uuid, desafiante uuid, desafiado uuid, nome_desafiante text, nome_desafiado text, trilha text,
               status text, criada_em timestamptz, expira_em timestamptz,
               premio_desafiante integer, premio_desafiado integer, vencedor text,
               placar_desafiante integer, placar_desafiado integer, placar_empates integer,
               saque boolean, valor integer, escudo boolean)
language plpgsql stable security definer set search_path = '' as $$
begin
  if public.ranking_meu_papel(p_ranking) is null then raise exception 'SEM_ACESSO'; end if;
  return query
  select d.id, d.desafiante, d.desafiado,
         coalesce(p1.nome, 'Jogador')::text, coalesce(p2.nome, 'Jogador')::text, d.trilha,
         public.disputa_status(d), d.criada_em, d.expira_em,
         case when public.disputa_status(d) = 'concluida' then d.d1_premio end,
         case when public.disputa_status(d) = 'concluida' then coalesce(d.d2_premio, 0) end,
         case when public.disputa_status(d) <> 'concluida' then null
              when public.disputa_vencedor(d) is null then 'empate'
              when public.disputa_vencedor(d) = d.desafiante then 'desafiante' else 'desafiado' end,
         pl.a, pl.b, pl.empates,
         d.saque, d.valor::int, d.escudo
  from public.disputas d
  left join public.perfis p1 on p1.id = d.desafiante
  left join public.perfis p2 on p2.id = d.desafiado
  cross join lateral public.disputa_placar(d.desafiante, d.desafiado) pl
  where d.ranking_id = p_ranking and d.d1_fim is not null and d.criada_em > now() - interval '7 days'
  order by d.criada_em desc
  limit 30;
end $$;

-- minhas disputas: também informam saque, valor, escudo usado e se ainda tenho escudo
drop function if exists public.minhas_disputas();
create function public.minhas_disputas()
returns table (id uuid, ranking text, outro text, sou_desafiante boolean, trilha text, horas integer, status text,
               expira_em timestamptz, criada_em timestamptz,
               meu_premio integer, meus_acertos integer, outro_premio integer, outro_acertos integer, resultado text,
               ranking_id uuid, outro_id uuid, placar_eu integer, placar_outro integer,
               saque boolean, valor integer, escudo boolean, escudo_livre boolean)
language sql stable security definer set search_path = '' as $$
  select d.id, r.nome, coalesce(pf.nome, 'Jogador')::text, d.desafiante = auth.uid(), d.trilha, d.horas::int,
         public.disputa_status(d), d.expira_em, d.criada_em,
         case when d.desafiante = auth.uid() then d.d1_premio else d.d2_premio end,
         (case when d.desafiante = auth.uid() then d.d1_acertos else d.d2_acertos end)::int,
         case when public.disputa_status(d) = 'concluida' then case when d.desafiante = auth.uid() then d.d2_premio else d.d1_premio end end,
         (case when public.disputa_status(d) = 'concluida' then case when d.desafiante = auth.uid() then d.d2_acertos else d.d1_acertos end end)::int,
         case when public.disputa_status(d) <> 'concluida' then null
              when public.disputa_vencedor(d) is null then 'empate'
              when public.disputa_vencedor(d) = auth.uid() then 'venci' else 'perdi' end,
         d.ranking_id,
         case when d.desafiante = auth.uid() then d.desafiado else d.desafiante end,
         pl.a, pl.b,
         d.saque, d.valor::int, d.escudo, public.saque_escudo_livre(auth.uid())
  from public.disputas d
  join public.rankings r on r.id = d.ranking_id
  left join public.perfis pf on pf.id = case when d.desafiante = auth.uid() then d.desafiado else d.desafiante end
  cross join lateral public.disputa_placar(auth.uid(), case when d.desafiante = auth.uid() then d.desafiado else d.desafiante end) pl
  where (d.desafiante = auth.uid() or (d.desafiado = auth.uid() and d.d1_fim is not null))
    and (public.disputa_status(d) in ('preparando','aguardando','jogando') or d.criada_em > now() - interval '48 hours')
  order by d.criada_em desc
  limit 20;
$$;

-- meus rankings: agora dizem se o Sábado do Saque está ativo
drop function if exists public.meus_rankings();
create function public.meus_rankings()
returns table (id uuid, nome text, codigo text, sou_dono boolean, membros integer, papel text, saque boolean)
language sql stable security definer set search_path = '' as $$
  select r.id, r.nome,
         case when m.papel in ('admin','lider','vice') then r.codigo end,
         r.dono = auth.uid(),
         (select count(*)::int from public.ranking_membros x where x.ranking_id = r.id),
         m.papel, r.saque
  from public.rankings r
  join public.ranking_membros m on m.ranking_id = r.id and m.user_id = auth.uid()
  order by m.entrou_em;
$$;

revoke all on function public.saque_agora(), public.saque_sabado(), public.saque_aberto(), public.saque_mov(public.disputas),
  public.ranking_pontos(uuid, timestamptz, timestamptz), public.saque_posicoes(uuid), public.saque_recebidos(uuid),
  public.saque_escudo_livre(uuid) from public, anon, authenticated;
revoke all on function public.tabela_semana(uuid, integer), public.campeoes_ranking(uuid), public.saque_info(uuid),
  public.definir_saque(uuid, boolean), public.criar_saque(uuid, uuid, text, integer[]), public.recusar_disputa(uuid),
  public.feed_disputas(uuid), public.minhas_disputas(), public.meus_rankings() from public, anon;
grant execute on function public.tabela_semana(uuid, integer), public.campeoes_ranking(uuid), public.saque_info(uuid),
  public.definir_saque(uuid, boolean), public.criar_saque(uuid, uuid, text, integer[]), public.recusar_disputa(uuid),
  public.feed_disputas(uuid), public.minhas_disputas(), public.meus_rankings() to authenticated;

select 'sábado do saque pronto' as status;
