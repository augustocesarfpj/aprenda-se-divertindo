-- Aprenda se Divertindo · 31 · Ranking: cargos e pontuação semanal
-- Rode depois do 25-ranking.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Cargos: administrador (quem criou) e líder têm os mesmos poderes; vice-líder convida; membro joga e desafia.
-- Até 2 líderes e 3 vice-líderes por ranking. Ninguém pode remover ou rebaixar o administrador.
-- A pontuação zera toda segunda-feira às 00h (horário de Brasília): nada é apagado, a tabela só mostra a semana.

alter table public.ranking_membros add column if not exists papel text not null default 'membro';
alter table public.ranking_membros drop constraint if exists ranking_membros_papel_check;
alter table public.ranking_membros add constraint ranking_membros_papel_check check (papel in ('admin','lider','vice','membro'));
update public.ranking_membros m set papel = 'admin'
  from public.rankings r where r.id = m.ranking_id and r.dono = m.user_id and m.papel <> 'admin';

-- papel de quem está logado num ranking (null se não for membro)
create or replace function public.ranking_meu_papel(p_ranking uuid)
returns text language sql stable security definer set search_path = '' as $$
  select papel from public.ranking_membros where ranking_id = p_ranking and user_id = auth.uid();
$$;

-- início da semana (segunda 00h de Brasília), com deslocamento: 0 = esta semana, 1 = a passada…
create or replace function public.ranking_inicio_semana(p_offset integer default 0)
returns timestamptz language sql stable set search_path = '' as $$
  select (date_trunc('week', now() at time zone 'America/Sao_Paulo') - make_interval(weeks => p_offset)) at time zone 'America/Sao_Paulo';
$$;

-- criar ranking: quem cria é administrador
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
  insert into public.ranking_membros (ranking_id, user_id, papel) values (v_id, uid, 'admin');
  return query select v_id, v_cod;
end $$;

-- meus rankings: o código do convite só aparece para administrador, líder e vice
drop function if exists public.meus_rankings();
create function public.meus_rankings()
returns table (id uuid, nome text, codigo text, sou_dono boolean, membros integer, papel text)
language sql stable security definer set search_path = '' as $$
  select r.id, r.nome,
         case when m.papel in ('admin','lider','vice') then r.codigo end,
         r.dono = auth.uid(),
         (select count(*)::int from public.ranking_membros x where x.ranking_id = r.id),
         m.papel
  from public.rankings r
  join public.ranking_membros m on m.ranking_id = r.id and m.user_id = auth.uid()
  order by m.entrou_em;
$$;

-- quando o administrador sai, a administração vai para um líder, depois um vice, depois o mais antigo
create or replace function public.ranking_passar_posse(p_user uuid, p_ranking uuid default null)
returns void
language plpgsql security definer set search_path = '' as $$
declare r record; novo uuid;
begin
  for r in select id from public.rankings where dono = p_user and (p_ranking is null or id = p_ranking) loop
    select m.user_id into novo from public.ranking_membros m
      where m.ranking_id = r.id and m.user_id <> p_user
      order by case m.papel when 'lider' then 0 when 'vice' then 1 else 2 end, m.entrou_em limit 1;
    if novo is null then delete from public.rankings where id = r.id;
    else
      update public.rankings set dono = novo where id = r.id;
      update public.ranking_membros set papel = 'admin' where ranking_id = r.id and user_id = novo;
    end if;
  end loop;
end $$;

-- confere se quem está logado administra o ranking (administrador ou líder)
create or replace function public.ranking_exigir_gestor(p_ranking uuid)
returns void language plpgsql stable security definer set search_path = '' as $$
begin
  if auth.uid() is null then raise exception 'LOGIN'; end if;
  if coalesce(public.ranking_meu_papel(p_ranking), '') not in ('admin','lider') then raise exception 'SEM_PERMISSAO'; end if;
end $$;

-- mudar o cargo de alguém (administrador e líder)
create or replace function public.definir_papel(p_ranking uuid, p_membro uuid, p_papel text)
returns void language plpgsql security definer set search_path = '' as $$
declare atual text;
begin
  perform public.ranking_exigir_gestor(p_ranking);
  if p_papel not in ('lider','vice','membro') then raise exception 'PAPEL_INVALIDO'; end if;
  select papel into atual from public.ranking_membros where ranking_id = p_ranking and user_id = p_membro;
  if atual is null then raise exception 'NAO_MEMBRO'; end if;
  if atual = 'admin' then raise exception 'NAO_PODE_ADMIN'; end if;
  if p_membro = auth.uid() then raise exception 'NAO_PODE_SI'; end if;
  if atual = p_papel then return; end if;
  if p_papel = 'lider' and (select count(*) from public.ranking_membros where ranking_id = p_ranking and papel = 'lider') >= 2 then
    raise exception 'LIMITE_LIDERES';
  end if;
  if p_papel = 'vice' and (select count(*) from public.ranking_membros where ranking_id = p_ranking and papel = 'vice') >= 3 then
    raise exception 'LIMITE_VICES';
  end if;
  update public.ranking_membros set papel = p_papel where ranking_id = p_ranking and user_id = p_membro;
end $$;

-- remover alguém do ranking (administrador e líder; o administrador não pode ser removido)
create or replace function public.remover_membro(p_ranking uuid, p_membro uuid)
returns void language plpgsql security definer set search_path = '' as $$
declare atual text;
begin
  perform public.ranking_exigir_gestor(p_ranking);
  select papel into atual from public.ranking_membros where ranking_id = p_ranking and user_id = p_membro;
  if atual is null then return; end if;
  if atual = 'admin' then raise exception 'NAO_PODE_ADMIN'; end if;
  if p_membro = auth.uid() then raise exception 'NAO_PODE_SI'; end if;
  delete from public.ranking_membros where ranking_id = p_ranking and user_id = p_membro;
end $$;

-- renomear (administrador e líder)
create or replace function public.renomear_ranking(p_ranking uuid, p_nome text)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.ranking_exigir_gestor(p_ranking);
  if char_length(btrim(coalesce(p_nome, ''))) not between 2 and 40 then raise exception 'NOME_INVALIDO'; end if;
  update public.rankings set nome = btrim(p_nome) where id = p_ranking;
end $$;

-- gerar um novo código de convite; o antigo deixa de funcionar (administrador e líder)
create or replace function public.novo_codigo_ranking(p_ranking uuid)
returns text language plpgsql security definer set search_path = '' as $$
declare v_cod text;
begin
  perform public.ranking_exigir_gestor(p_ranking);
  loop
    v_cod := upper(substr(translate(encode(extensions.gen_random_bytes(8), 'base64'), '+/=0O1Il', ''), 1, 6));
    exit when char_length(v_cod) = 6 and not exists (select 1 from public.rankings r where r.codigo = v_cod);
  end loop;
  update public.rankings set codigo = v_cod where id = p_ranking;
  return v_cod;
end $$;

-- apagar o ranking inteiro (administrador e líder)
create or replace function public.apagar_ranking(p_ranking uuid)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.ranking_exigir_gestor(p_ranking);
  delete from public.rankings where id = p_ranking;
end $$;

-- pontos de cada membro numa semana: 1 ponto por acerto nas partidas feitas com a conta
create or replace function public.ranking_pontos(p_ranking uuid, p_ini timestamptz, p_fim timestamptz)
returns table (user_id uuid, pontos integer, partidas integer, acertos integer, respondidas integer, maior_premio integer)
language sql stable security definer set search_path = '' as $$
  select m.user_id,
         coalesce(sum(p.acertos), 0)::int,
         count(p.id)::int,
         coalesce(sum(p.acertos), 0)::int,
         coalesce(sum(p.respondidas), 0)::int,
         coalesce(max(p.premio), 0)::int
  from public.ranking_membros m
  left join public.partidas p on p.user_id = m.user_id and p.criado_em >= p_ini and p.criado_em < p_fim
  where m.ranking_id = p_ranking
  group by m.user_id;
$$;

-- tabela da semana (0 = atual, 1 = passada), com cargo e o campeão da semana anterior
create or replace function public.tabela_semana(p_id uuid, p_semana integer default 0)
returns table (membro uuid, nome text, papel text, pontos integer, partidas integer, acertos integer,
               respondidas integer, maior_premio integer, campeao boolean, sou_eu boolean)
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
         x.pontos, x.partidas, x.acertos, x.respondidas, x.maior_premio,
         (topo > 0 and coalesce(a.pontos, 0) = topo),
         m.user_id = auth.uid()
  from public.ranking_membros m
  join public.ranking_pontos(p_id, ini, fim) x on x.user_id = m.user_id
  left join public.ranking_pontos(p_id, public.ranking_inicio_semana(p_semana + 1), ini) a on a.user_id = m.user_id
  left join public.perfis pf on pf.id = m.user_id
  where m.ranking_id = p_id
  order by x.pontos desc,
           (case when x.respondidas > 0 then x.acertos::numeric / x.respondidas else 0 end) desc,
           x.partidas desc, m.entrou_em;
end $$;

-- campeões das últimas semanas (desde a criação do ranking, até 8 semanas)
create or replace function public.campeoes_ranking(p_id uuid)
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

revoke all on function public.ranking_exigir_gestor(uuid), public.ranking_pontos(uuid, timestamptz, timestamptz),
  public.ranking_passar_posse(uuid, uuid) from public, anon, authenticated;
revoke all on function public.ranking_meu_papel(uuid), public.ranking_inicio_semana(integer),
  public.criar_ranking(text), public.meus_rankings(), public.definir_papel(uuid, uuid, text),
  public.remover_membro(uuid, uuid), public.renomear_ranking(uuid, text), public.novo_codigo_ranking(uuid),
  public.apagar_ranking(uuid), public.tabela_semana(uuid, integer), public.campeoes_ranking(uuid) from public, anon;
grant execute on function public.ranking_meu_papel(uuid), public.ranking_inicio_semana(integer),
  public.criar_ranking(text), public.meus_rankings(), public.definir_papel(uuid, uuid, text),
  public.remover_membro(uuid, uuid), public.renomear_ranking(uuid, text), public.novo_codigo_ranking(uuid),
  public.apagar_ranking(uuid), public.tabela_semana(uuid, integer), public.campeoes_ranking(uuid) to authenticated;

select 'cargos e semana prontos' as status;
