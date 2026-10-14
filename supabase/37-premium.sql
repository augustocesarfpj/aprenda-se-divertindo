-- Aprenda se Divertindo · 37 · Plano Premium
-- Rode depois do 36-ranking-bonus-distancia.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Grátis (com conta): 5 provas por dia, 3 cartões de estudo por dia e 1 disputa nova por dia.
-- Premium: tudo ilimitado e selo 💎 no ranking.
-- Quem já tinha conta quando este arquivo rodou pela primeira vez ganha 30 dias de Premium (fundadores).
-- Para liberar o Premium de alguém depois do Pix, use o arquivo liberar-premium.sql.

create table if not exists public.assinaturas (
  user_id       uuid primary key references auth.users (id) on delete cascade,
  ate           timestamptz not null,
  origem        text not null default 'pix',
  atualizado_em timestamptz not null default now()
);
alter table public.assinaturas enable row level security;
revoke all on public.assinaturas from anon, authenticated;

-- fundadores: 30 dias grátis para quem já tem conta (só na primeira vez)
insert into public.assinaturas (user_id, ate, origem)
select u.id, now() + interval '30 days', 'fundador' from auth.users u
on conflict (user_id) do nothing;

create or replace function public.eh_premium(p_user uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (select 1 from public.assinaturas a where a.user_id = p_user and a.ate > now());
$$;

-- situação do plano de quem está logado e o uso de hoje (horário de Brasília)
create or replace function public.meu_plano()
returns table (premium boolean, ate timestamptz, origem text, provas_hoje integer, cartoes_hoje integer, disputas_hoje integer)
language sql stable security definer set search_path = '' as $$
  select public.eh_premium(auth.uid()),
         (select a.ate from public.assinaturas a where a.user_id = auth.uid()),
         (select a.origem from public.assinaturas a where a.user_id = auth.uid()),
         (select count(*)::int from public.partidas p where p.user_id = auth.uid() and p.modo = 'classico'
            and p.dia = (now() at time zone 'America/Sao_Paulo')::date),
         (select count(*)::int from public.estudo e where e.user_id = auth.uid()
            and (e.atualizado_em at time zone 'America/Sao_Paulo')::date = (now() at time zone 'America/Sao_Paulo')::date),
         (select count(*)::int from public.disputas d where d.desafiante = auth.uid()
            and (d.criada_em at time zone 'America/Sao_Paulo')::date = (now() at time zone 'America/Sao_Paulo')::date);
$$;

-- criar disputa: quem não é Premium cria 1 por dia (aceitar desafios é sempre liberado)
create or replace function public.criar_disputa(p_ranking uuid, p_desafiado uuid, p_trilha text, p_horas integer, p_questoes integer[])
returns uuid language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); v_id uuid;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  if public.ranking_meu_papel(p_ranking) is null then raise exception 'SEM_ACESSO'; end if;
  if p_desafiado = uid then raise exception 'NAO_PODE_SI'; end if;
  if not exists (select 1 from public.ranking_membros where ranking_id = p_ranking and user_id = p_desafiado) then raise exception 'NAO_MEMBRO'; end if;
  if p_horas not in (5, 24) then raise exception 'PRAZO_INVALIDO'; end if;
  delete from public.disputas d where d.desafiante = uid and d.d1_fim is null and d.recusada_em is null;
  if not public.eh_premium(uid) and (select count(*) from public.disputas d where d.desafiante = uid
        and (d.criada_em at time zone 'America/Sao_Paulo')::date = (now() at time zone 'America/Sao_Paulo')::date) >= 1 then
    raise exception 'LIMITE_DIARIO';
  end if;
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
  insert into public.disputas (ranking_id, desafiante, desafiado, trilha, horas, questoes, expira_em)
  values (p_ranking, uid, p_desafiado, p_trilha, p_horas, p_questoes, now() + make_interval(hours => p_horas))
  returning id into v_id;
  return v_id;
end $$;

-- tabela da semana com o selo 💎 de quem é Premium
drop function if exists public.tabela_semana(uuid, integer);
create function public.tabela_semana(p_id uuid, p_semana integer default 0)
returns table (membro uuid, nome text, papel text, pontos integer, partidas integer, acertos integer,
               respondidas integer, maior_premio integer, vitorias integer, empates integer, derrotas integer,
               bonus integer, mais_longe integer, milhoes integer, campeao boolean, sou_eu boolean, premium boolean)
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
         x.bonus, x.mais_longe, x.milhoes,
         (topo > 0 and coalesce(a.pontos, 0) = topo),
         m.user_id = auth.uid(),
         public.eh_premium(m.user_id)
  from public.ranking_membros m
  join public.ranking_pontos(p_id, ini, fim) x on x.user_id = m.user_id
  left join public.ranking_pontos(p_id, public.ranking_inicio_semana(p_semana + 1), ini) a on a.user_id = m.user_id
  left join public.perfis pf on pf.id = m.user_id
  where m.ranking_id = p_id
  order by x.pontos desc, x.mais_longe desc, x.vitorias desc,
           (case when x.respondidas > 0 then x.acertos::numeric / x.respondidas else 0 end) desc,
           x.partidas desc, m.entrou_em;
end $$;

revoke all on function public.eh_premium(uuid) from public, anon, authenticated;
revoke all on function public.meu_plano(), public.criar_disputa(uuid, uuid, text, integer, integer[]),
  public.tabela_semana(uuid, integer) from public, anon;
grant execute on function public.meu_plano(), public.criar_disputa(uuid, uuid, text, integer, integer[]),
  public.tabela_semana(uuid, integer) to authenticated;

select count(*) as fundadores_com_30_dias from public.assinaturas where origem = 'fundador';
