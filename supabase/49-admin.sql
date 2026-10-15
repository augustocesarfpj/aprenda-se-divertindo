-- Aprenda se Divertindo · 49 · Página de administração (admin.html)
-- Rode depois do 48-sabado-do-saque.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Cria a lista de administradores e as funções que alimentam a página admin.html.
-- Cada função confere se quem pediu é administrador; para qualquer outra pessoa, devolve SEM_PERMISSAO.
-- Nada aqui altera dados dos jogadores: só leitura.
--
-- Para dar acesso a outra pessoa no futuro:
--   insert into public.admins (user_id) select id from auth.users where email = 'email@da.pessoa';

create table if not exists public.admins (
  user_id   uuid primary key references auth.users (id) on delete cascade,
  criado_em timestamptz not null default now()
);
alter table public.admins enable row level security;
revoke all on public.admins from anon, authenticated;

-- o primeiro administrador: o criador do jogo
insert into public.admins (user_id)
select id from auth.users where lower(email) = 'augustocesarfpj@gmail.com'
on conflict do nothing;

create or replace function public.admin_eu()
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (select 1 from public.admins a where a.user_id = auth.uid());
$$;

create or replace function public.admin_exigir()
returns void language plpgsql stable security definer set search_path = '' as $$
begin
  if auth.uid() is null then raise exception 'LOGIN'; end if;
  if not public.admin_eu() then raise exception 'SEM_PERMISSAO'; end if;
end $$;

-- resumo por dia (visitantes, contas, partidas)
create or replace function public.admin_resumo(p_dias integer default 30)
returns table (dia date, visitantes integer, visitantes_com_conta integer, partidas_sem_conta integer,
               partidas_com_conta integer, jogadores_com_conta integer, contas_novas integer)
language plpgsql stable security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return query
  select r.dia, r.visitantes::int, r.visitantes_com_conta::int, r.partidas_sem_conta::int,
         r.partidas_com_conta::int, r.jogadores_com_conta::int, r.contas_novas::int
  from public.resumo_diario r
  where r.dia > (now() at time zone 'America/Sao_Paulo')::date - greatest(1, least(coalesce(p_dias, 30), 365))
  order by r.dia;
end $$;

-- números gerais
create or replace function public.admin_totais()
returns json language plpgsql stable security definer set search_path = '' as $$
declare hoje date := (now() at time zone 'America/Sao_Paulo')::date;
begin
  perform public.admin_exigir();
  return json_build_object(
    'contas',            (select count(*) from auth.users),
    'contas_7d',         (select count(*) from auth.users where created_at > now() - interval '7 days'),
    'partidas',          (select count(*) from public.partidas) + (select count(*) from public.partidas_anonimas),
    'partidas_7d',       (select count(*) from public.partidas where dia > hoje - 7) + (select count(*) from public.partidas_anonimas where dia > hoje - 7),
    'ativos_hoje',       (select count(distinct user_id) from public.partidas where dia = hoje),
    'ativos_7d',         (select count(distinct user_id) from public.partidas where dia > hoje - 7),
    'ativos_30d',        (select count(distinct user_id) from public.partidas where dia > hoje - 30),
    'milhoes',           (select count(*) from public.partidas where premio >= 1000000),
    'questoes',          (select count(*) from public.questoes),
    'rankings',          (select count(*) from public.rankings),
    'disputas_7d',       (select count(*) from public.disputas where criada_em > now() - interval '7 days' and d1_fim is not null),
    'saques_7d',         (select count(*) from public.disputas where saque and criada_em > now() - interval '7 days' and d1_fim is not null),
    'em_estudo',         (select count(distinct user_id) from public.estudo),
    'cartoes',           (select count(*) from public.estudo)
  );
end $$;

-- retenção: de cada semana de cadastro, quantos jogaram na mesma semana e nas 4 seguintes
create or replace function public.admin_retencao(p_semanas integer default 8)
returns table (semana date, contas integer, s0 integer, s1 integer, s2 integer, s3 integer, s4 integer)
language plpgsql stable security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return query
  with u as (
    select x.id, date_trunc('week', x.created_at at time zone 'America/Sao_Paulo')::date as w
    from auth.users x
  ), j as (
    select distinct p.user_id, date_trunc('week', p.dia)::date as w from public.partidas p
  )
  select u.w, count(*)::int,
         count(*) filter (where exists (select 1 from j where j.user_id = u.id and j.w = u.w))::int,
         count(*) filter (where exists (select 1 from j where j.user_id = u.id and j.w = u.w + 7))::int,
         count(*) filter (where exists (select 1 from j where j.user_id = u.id and j.w = u.w + 14))::int,
         count(*) filter (where exists (select 1 from j where j.user_id = u.id and j.w = u.w + 21))::int,
         count(*) filter (where exists (select 1 from j where j.user_id = u.id and j.w = u.w + 28))::int
  from u
  where u.w > (now() at time zone 'America/Sao_Paulo')::date - 7 * greatest(1, least(coalesce(p_semanas, 8), 52))
  group by u.w
  order by u.w desc;
end $$;

-- jogadores com conta
create or replace function public.admin_jogadores()
returns table (id uuid, nome text, email text, criado_em timestamptz, ultimo_jogo timestamptz,
               partidas integer, partidas_7d integer, melhor_premio integer, milhoes integer, trilha text,
               faceis_vistas integer, intermediarias_vistas integer, vistas integer, cartoes integer, rankings integer)
language plpgsql stable security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return query
  select x.id, coalesce(pf.nome, '(sem perfil)')::text, x.email::text, x.created_at,
         pa.ultimo, coalesce(pa.n, 0)::int, coalesce(pa.n7, 0)::int, coalesce(pa.melhor, 0)::int, coalesce(pa.mil, 0)::int,
         (select p2.trilha from public.partidas p2 where p2.user_id = x.id group by p2.trilha order by count(*) desc limit 1),
         coalesce(sv.f, 0)::int, coalesce(sv.i, 0)::int, coalesce(sv.t, 0)::int,
         (select count(*) from public.estudo e where e.user_id = x.id)::int,
         (select count(*) from public.ranking_membros m where m.user_id = x.id)::int
  from auth.users x
  left join public.perfis pf on pf.id = x.id
  left join lateral (
    select max(p.criado_em) as ultimo, count(*) as n, count(*) filter (where p.criado_em > now() - interval '7 days') as n7,
           max(p.premio) as melhor, count(*) filter (where p.premio >= 1000000) as mil
    from public.partidas p where p.user_id = x.id
  ) pa on true
  left join lateral (
    select count(*) filter (where q.nivel = 0) as f, count(*) filter (where q.nivel = 1) as i, count(*) as t
    from jsonb_array_elements_text(case when jsonb_typeof(pf.progresso->'seen') = 'array' then pf.progresso->'seen' else '[]'::jsonb end) s(v)
    join public.questoes q on q.id = case when s.v ~ '^[0-9]+$' then s.v::int end
  ) sv on true
  order by pa.ultimo desc nulls last, x.created_at desc;
end $$;

-- questões por matéria e nível (a página soma por trilha)
create or replace function public.admin_questoes()
returns table (materia text, nivel integer, qtd integer)
language plpgsql stable security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return query select q.materia::text, q.nivel::int, count(*)::int from public.questoes q group by 1, 2 order by 1, 2;
end $$;

-- partidas por trilha e modo, nos últimos dias
create or replace function public.admin_trilhas(p_dias integer default 30)
returns table (trilha text, modo text, partidas integer, jogadores integer, sem_conta integer)
language plpgsql stable security definer set search_path = '' as $$
declare desde date := (now() at time zone 'America/Sao_Paulo')::date - greatest(1, least(coalesce(p_dias, 30), 365));
begin
  perform public.admin_exigir();
  return query
  select coalesce(a.trilha, b.trilha), coalesce(a.modo, b.modo),
         coalesce(a.n, 0)::int, coalesce(a.j, 0)::int, coalesce(b.n, 0)::int
  from (select p.trilha, p.modo, count(*) n, count(distinct p.user_id) j from public.partidas p where p.dia > desde group by 1, 2) a
  full join (select p.trilha, p.modo, count(*) n from public.partidas_anonimas p where p.dia > desde group by 1, 2) b
    on a.trilha = b.trilha and a.modo = b.modo
  order by 3 desc, 5 desc;
end $$;

-- rankings
create or replace function public.admin_rankings()
returns table (id uuid, nome text, dono text, membros integer, saque boolean, criado_em timestamptz,
               disputas_7d integer, saques_7d integer, partidas_semana integer)
language plpgsql stable security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return query
  select r.id, r.nome, coalesce(pf.nome, '?')::text,
         (select count(*) from public.ranking_membros m where m.ranking_id = r.id)::int,
         r.saque, r.criado_em,
         (select count(*) from public.disputas d where d.ranking_id = r.id and d.d1_fim is not null and d.criada_em > now() - interval '7 days')::int,
         (select count(*) from public.disputas d where d.ranking_id = r.id and d.saque and d.d1_fim is not null and d.criada_em > now() - interval '7 days')::int,
         (select count(*) from public.partidas p join public.ranking_membros m on m.user_id = p.user_id and m.ranking_id = r.id
           where p.criado_em >= public.ranking_inicio_semana(0))::int
  from public.rankings r
  left join public.perfis pf on pf.id = r.dono
  order by 9 desc, 4 desc;
end $$;

revoke all on function public.admin_exigir() from public, anon, authenticated;
revoke all on function public.admin_eu(), public.admin_resumo(integer), public.admin_totais(), public.admin_retencao(integer),
  public.admin_jogadores(), public.admin_questoes(), public.admin_trilhas(integer), public.admin_rankings() from public, anon;
grant execute on function public.admin_eu(), public.admin_resumo(integer), public.admin_totais(), public.admin_retencao(integer),
  public.admin_jogadores(), public.admin_questoes(), public.admin_trilhas(integer), public.admin_rankings() to authenticated;

select 'administração pronta' as status, (select count(*) from public.admins) as administradores;
