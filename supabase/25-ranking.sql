-- Aprenda se Divertindo · 25 · Ranking entre amigos
-- Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Cada pessoa participa de no máximo 3 rankings. Cada ranking tem até 50 participantes.
-- As tabelas não são lidas direto pelo jogo: tudo passa pelas funções abaixo,
-- que conferem quem está logado e se a pessoa é membro do ranking.

create table if not exists public.rankings (
  id         uuid primary key default gen_random_uuid(),
  nome       text not null check (char_length(btrim(nome)) between 2 and 40),
  codigo     text not null unique,
  dono       uuid not null references auth.users (id) on delete cascade,
  criado_em  timestamptz not null default now()
);

create table if not exists public.ranking_membros (
  ranking_id uuid not null references public.rankings (id) on delete cascade,
  user_id    uuid not null references auth.users (id) on delete cascade,
  entrou_em  timestamptz not null default now(),
  primary key (ranking_id, user_id)
);
create index if not exists ranking_membros_user on public.ranking_membros (user_id);

alter table public.rankings enable row level security;
alter table public.ranking_membros enable row level security;
revoke all on public.rankings, public.ranking_membros from anon, authenticated;

-- limites: 3 rankings por pessoa e 50 pessoas por ranking
create or replace function public.ranking_limites()
returns trigger language plpgsql set search_path = '' as $$
begin
  if (select count(*) from public.ranking_membros where user_id = new.user_id) >= 3 then
    raise exception 'LIMITE_RANKINGS';
  end if;
  if (select count(*) from public.ranking_membros where ranking_id = new.ranking_id) >= 50 then
    raise exception 'RANKING_CHEIO';
  end if;
  return new;
end $$;
drop trigger if exists ranking_limites on public.ranking_membros;
create trigger ranking_limites before insert on public.ranking_membros
  for each row execute function public.ranking_limites();

-- criar um ranking (quem cria já entra nele)
create or replace function public.criar_ranking(p_nome text)
returns table (id uuid, codigo text)
language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); v_id uuid; v_cod text;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  if (select count(*) from public.ranking_membros m where m.user_id = uid) >= 3 then
    raise exception 'LIMITE_RANKINGS';
  end if;
  loop
    v_cod := upper(substr(translate(encode(extensions.gen_random_bytes(8), 'base64'), '+/=0O1Il', ''), 1, 6));
    exit when char_length(v_cod) = 6 and not exists (select 1 from public.rankings r where r.codigo = v_cod);
  end loop;
  insert into public.rankings (nome, codigo, dono) values (btrim(p_nome), v_cod, uid) returning rankings.id into v_id;
  insert into public.ranking_membros (ranking_id, user_id) values (v_id, uid);
  return query select v_id, v_cod;
end $$;

-- rankings de quem está logado
create or replace function public.meus_rankings()
returns table (id uuid, nome text, codigo text, sou_dono boolean, membros integer)
language sql stable security definer set search_path = '' as $$
  select r.id, r.nome, r.codigo, r.dono = auth.uid(),
         (select count(*)::int from public.ranking_membros x where x.ranking_id = r.id)
  from public.rankings r
  join public.ranking_membros m on m.ranking_id = r.id and m.user_id = auth.uid()
  order by m.entrou_em;
$$;

-- prévia do convite (funciona até sem login, para mostrar o nome do ranking)
create or replace function public.ver_convite(p_codigo text)
returns table (nome text, membros integer)
language sql stable security definer set search_path = '' as $$
  select r.nome, (select count(*)::int from public.ranking_membros x where x.ranking_id = r.id)
  from public.rankings r where r.codigo = upper(btrim(p_codigo));
$$;

-- entrar pelo código do convite
create or replace function public.entrar_ranking(p_codigo text)
returns uuid
language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); v_id uuid;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  select r.id into v_id from public.rankings r where r.codigo = upper(btrim(p_codigo));
  if v_id is null then raise exception 'CODIGO_INVALIDO'; end if;
  if not exists (select 1 from public.ranking_membros m where m.ranking_id = v_id and m.user_id = uid) then
    insert into public.ranking_membros (ranking_id, user_id) values (v_id, uid);
  end if;
  return v_id;
end $$;

-- passa a posse dos rankings de alguém para o membro mais antigo (ou apaga, se ficar vazio)
create or replace function public.ranking_passar_posse(p_user uuid, p_ranking uuid default null)
returns void
language plpgsql security definer set search_path = '' as $$
declare r record; novo uuid;
begin
  for r in select id from public.rankings where dono = p_user and (p_ranking is null or id = p_ranking) loop
    select m.user_id into novo from public.ranking_membros m
      where m.ranking_id = r.id and m.user_id <> p_user order by m.entrou_em limit 1;
    if novo is null then delete from public.rankings where id = r.id;
    else update public.rankings set dono = novo where id = r.id; end if;
  end loop;
end $$;

-- sair de um ranking
create or replace function public.sair_ranking(p_id uuid)
returns void
language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid();
begin
  if uid is null then raise exception 'LOGIN'; end if;
  perform public.ranking_passar_posse(uid, p_id);
  delete from public.ranking_membros where ranking_id = p_id and user_id = uid;
end $$;

-- tabela de classificação (só para quem é membro)
create or replace function public.tabela_ranking(p_id uuid, p_desde timestamptz default null)
returns table (nome text, partidas integer, maior_premio integer, acertos integer, respondidas integer, sou_eu boolean)
language plpgsql stable security definer set search_path = '' as $$
begin
  if not exists (select 1 from public.ranking_membros m where m.ranking_id = p_id and m.user_id = auth.uid()) then
    raise exception 'SEM_ACESSO';
  end if;
  return query
  select coalesce(pf.nome, 'Jogador')::text,
         count(p.id)::int,
         coalesce(max(p.premio), 0)::int,
         coalesce(sum(p.acertos), 0)::int,
         coalesce(sum(p.respondidas), 0)::int,
         m.user_id = auth.uid()
  from public.ranking_membros m
  left join public.perfis pf on pf.id = m.user_id
  left join public.partidas p on p.user_id = m.user_id and (p_desde is null or p.criado_em >= p_desde)
  where m.ranking_id = p_id
  group by m.user_id, pf.nome
  order by 3 desc, (case when coalesce(sum(p.respondidas), 0) > 0 then sum(p.acertos)::numeric / sum(p.respondidas) else 0 end) desc, 2 desc;
end $$;

-- a exclusão de conta passa a entregar os rankings da pessoa a outro membro
create or replace function public.excluir_minha_conta()
returns void language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid();
begin
  if uid is null then raise exception 'É preciso estar logado para excluir a conta.'; end if;
  perform public.ranking_passar_posse(uid);
  delete from public.ranking_membros where user_id = uid;
  delete from public.estudo   where user_id = uid;
  delete from public.partidas where user_id = uid;
  delete from public.perfis   where id = uid;
  delete from auth.users      where id = uid;
end $$;

revoke all on function public.ranking_limites() from public, anon, authenticated;
revoke all on function public.ranking_passar_posse(uuid, uuid) from public, anon, authenticated;
revoke all on function public.criar_ranking(text), public.meus_rankings(), public.entrar_ranking(text),
  public.sair_ranking(uuid), public.tabela_ranking(uuid, timestamptz), public.excluir_minha_conta() from public, anon;
grant execute on function public.criar_ranking(text), public.meus_rankings(), public.entrar_ranking(text),
  public.sair_ranking(uuid), public.tabela_ranking(uuid, timestamptz), public.excluir_minha_conta() to authenticated;
revoke all on function public.ver_convite(text) from public;
grant execute on function public.ver_convite(text) to anon, authenticated;

select 'ranking pronto' as status;
