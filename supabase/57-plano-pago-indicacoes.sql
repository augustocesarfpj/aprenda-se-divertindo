-- Aprenda se Divertindo · 57 · Plano pago (Premium), pagamentos por Pix e programa de indicação
-- Rode depois do 56-trilha-enem-13.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- O que este arquivo faz:
--   • Plano grátis (com conta): 5 provas e 5 cartões de estudo por dia. Premium: tudo ilimitado.
--   • Planos: mensal, trimestral, semestral e anual (R$ 12,90 por mês; os preços se mudam na administração).
--   • Pagamento por Pix: o jogador escolhe o plano, paga e avisa; a administração confirma e o Premium é liberado.
--   • Presente: quem já tem conta quando este arquivo roda pela primeira vez ganha 3 meses de Premium (plano trimestral).
--   • Indicação (promoção por tempo limitado): quem indica ganha R$ 2,90 a cada pagamento confirmado do indicado,
--     enquanto ele mantiver a assinatura. As comissões fecham no dia 30 e são liberadas no dia 5 do mês seguinte.
--     Saque a partir de R$ 50,00.
--   • Tudo isso se administra pela página admin.html: confirmar pagamentos, habilitar e remover Premium,
--     saques, e-mails de notificação, chave Pix, preços, promoção e administradores.

-- ============ configurações ============
create table if not exists public.config (
  chave         text primary key,
  valor         jsonb not null,
  atualizado_em timestamptz not null default now()
);
alter table public.config enable row level security;
revoke all on public.config from anon, authenticated;

insert into public.config (chave, valor) values
  ('cobranca',  '{"ativa": true}'),
  ('limites',   '{"provas": 5, "cartoes": 5}'),
  ('precos',    '{"mensal": 12.90, "trimestral": 38.70, "semestral": 77.40, "anual": 154.80}'),
  ('pix',       '{"chave": "", "nome": "", "cidade": "", "whats": ""}'),
  ('emails',    '["augustocesarfpj@gmail.com", "mirellefranca.sms@gmail.com"]'),
  ('indicacao', '{"ativa": true, "fim": null, "valor": 2.90, "minimo": 50}')
on conflict (chave) do nothing;

-- relógio (separado para poder testar)
create or replace function public.plano_agora()
returns timestamptz language sql stable set search_path = '' as $$ select now() $$;

create or replace function public.plano_hoje()
returns date language sql stable set search_path = '' as $$ select (public.plano_agora() at time zone 'America/Sao_Paulo')::date $$;

create or replace function public.cfg(p_chave text)
returns jsonb language sql stable security definer set search_path = '' as $$
  select c.valor from public.config c where c.chave = p_chave;
$$;

create or replace function public.plano_meses(p_plano text)
returns integer language sql immutable set search_path = '' as $$
  select case p_plano when 'mensal' then 1 when 'trimestral' then 3 when 'semestral' then 6 when 'anual' then 12 end;
$$;

create or replace function public.indicacao_ativa()
returns boolean language sql stable security definer set search_path = '' as $$
  select coalesce((public.cfg('indicacao')->>'ativa')::boolean, false)
     and (nullif(public.cfg('indicacao')->>'fim', '') is null
          or public.plano_hoje() <= (public.cfg('indicacao')->>'fim')::date);
$$;

-- a comissão do dia D fecha no dia 30 do mês (o dia 31 já conta para o mês seguinte) e é liberada no dia 5 do mês seguinte ao fechamento
create or replace function public.comissao_libera_em(p_quando timestamptz)
returns date language sql stable set search_path = '' as $$
  select (date_trunc('month', d)::date + case when extract(day from d) > 30 then interval '2 months' else interval '1 month' end)::date + 4
  from (select (p_quando at time zone 'America/Sao_Paulo')::date as d) x;
$$;

-- ============ tabelas ============
create table if not exists public.assinaturas (
  user_id       uuid primary key references auth.users (id) on delete cascade,
  ate           timestamptz not null,
  origem        text not null default 'pix',
  atualizado_em timestamptz not null default now()
);
alter table public.assinaturas add column if not exists plano text;
alter table public.assinaturas enable row level security;
revoke all on public.assinaturas from anon, authenticated;

create table if not exists public.pagamentos (
  id           uuid primary key default gen_random_uuid(),
  user_id      uuid references auth.users (id) on delete set null,
  email        text,
  plano        text not null check (plano in ('mensal', 'trimestral', 'semestral', 'anual')),
  meses        integer not null,
  valor        numeric(10, 2) not null,
  tipo         text not null default 'pix' check (tipo in ('pix', 'manual', 'cortesia')),
  status       text not null default 'pendente' check (status in ('pendente', 'confirmado', 'recusado', 'cancelado')),
  criado_em    timestamptz not null default now(),
  decidido_em  timestamptz,
  decidido_por uuid references auth.users (id) on delete set null,
  obs          text
);
create index if not exists pagamentos_status on public.pagamentos (status, criado_em desc);
create index if not exists pagamentos_user on public.pagamentos (user_id);
alter table public.pagamentos enable row level security;
revoke all on public.pagamentos from anon, authenticated;

create table if not exists public.codigos_indicacao (
  user_id   uuid primary key references auth.users (id) on delete cascade,
  codigo    text not null unique,
  criado_em timestamptz not null default now()
);
alter table public.codigos_indicacao enable row level security;
revoke all on public.codigos_indicacao from anon, authenticated;

create table if not exists public.indicacoes (
  indicado  uuid primary key references auth.users (id) on delete cascade,
  indicador uuid not null references auth.users (id) on delete cascade,
  criado_em timestamptz not null default now()
);
create index if not exists indicacoes_indicador on public.indicacoes (indicador);
alter table public.indicacoes enable row level security;
revoke all on public.indicacoes from anon, authenticated;

create table if not exists public.saques (
  id           uuid primary key default gen_random_uuid(),
  user_id      uuid references auth.users (id) on delete set null,
  email        text,
  valor        numeric(10, 2) not null,
  chave_pix    text not null,
  status       text not null default 'pendente' check (status in ('pendente', 'pago', 'recusado')),
  criado_em    timestamptz not null default now(),
  decidido_em  timestamptz,
  decidido_por uuid references auth.users (id) on delete set null,
  obs          text
);
alter table public.saques enable row level security;
revoke all on public.saques from anon, authenticated;

create table if not exists public.comissoes (
  id           uuid primary key default gen_random_uuid(),
  indicador    uuid not null references auth.users (id) on delete cascade,
  indicado     uuid references auth.users (id) on delete set null,
  pagamento_id uuid unique references public.pagamentos (id) on delete set null,
  valor        numeric(10, 2) not null,
  criado_em    timestamptz not null default now(),
  libera_em    date not null,
  saque_id     uuid references public.saques (id) on delete set null
);
create index if not exists comissoes_indicador on public.comissoes (indicador);
alter table public.comissoes enable row level security;
revoke all on public.comissoes from anon, authenticated;

-- segunda administradora
insert into public.admins (user_id)
select id from auth.users where lower(email) = 'mirellefranca.sms@gmail.com'
on conflict do nothing;

-- presente: 3 meses (plano trimestral) para quem já tem conta, só na primeira vez que o arquivo roda
do $$
begin
  if not exists (select 1 from public.config where chave = 'presente_fundadores') then
    insert into public.assinaturas (user_id, ate, origem, plano)
    select u.id, now() + interval '3 months', 'fundador', 'trimestral' from auth.users u
    on conflict (user_id) do update
      set ate = greatest(public.assinaturas.ate, excluded.ate), origem = 'fundador', plano = 'trimestral', atualizado_em = now();
    insert into public.config (chave, valor)
    values ('presente_fundadores', jsonb_build_object('em', now(), 'contas', (select count(*) from auth.users)));
  end if;
end $$;

-- ============ regras internas ============
create or replace function public.eh_premium(p_user uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (select 1 from public.assinaturas a where a.user_id = p_user and a.ate > public.plano_agora());
$$;

-- soma os meses ao que ainda falta (ou a partir de agora)
create or replace function public.premium_estender(p_user uuid, p_meses integer, p_origem text, p_plano text)
returns timestamptz language plpgsql security definer set search_path = '' as $$
declare v timestamptz;
begin
  insert into public.assinaturas (user_id, ate, origem, plano)
  values (p_user, public.plano_agora() + make_interval(months => p_meses), p_origem, p_plano)
  on conflict (user_id) do update
    set ate = greatest(public.assinaturas.ate, public.plano_agora()) + make_interval(months => p_meses),
        origem = p_origem, plano = p_plano, atualizado_em = now()
  returning ate into v;
  return v;
end $$;

-- comissão do indicador, se o pagamento foi pago de verdade e o indicado veio por indicação
create or replace function public.gerar_comissao(p_pagamento uuid)
returns numeric language plpgsql security definer set search_path = '' as $$
declare p public.pagamentos; i public.indicacoes; v numeric;
begin
  select * into p from public.pagamentos where id = p_pagamento;
  if p.id is null or p.status <> 'confirmado' or p.tipo = 'cortesia' or p.valor <= 0 or p.user_id is null then return 0; end if;
  select * into i from public.indicacoes where indicado = p.user_id;
  if i.indicador is null then return 0; end if;
  v := coalesce((public.cfg('indicacao')->>'valor')::numeric, 2.90);
  insert into public.comissoes (indicador, indicado, pagamento_id, valor, libera_em)
  values (i.indicador, p.user_id, p.id, v, public.comissao_libera_em(public.plano_agora()))
  on conflict (pagamento_id) do nothing;
  return v;
end $$;

-- ============ para o jogador ============
-- preços, limites, Pix e regras da indicação (aparece até para quem não entrou na conta)
create or replace function public.plano_info()
returns json language sql stable security definer set search_path = '' as $$
  select json_build_object(
    'cobranca',  coalesce((public.cfg('cobranca')->>'ativa')::boolean, false),
    'limites',   public.cfg('limites'),
    'precos',    public.cfg('precos'),
    'pix',       public.cfg('pix'),
    'emails',    public.cfg('emails'),
    'indicacao', json_build_object('ativa', public.indicacao_ativa(),
                                   'fim', nullif(public.cfg('indicacao')->>'fim', ''),
                                   'valor', (public.cfg('indicacao')->>'valor')::numeric,
                                   'minimo', (public.cfg('indicacao')->>'minimo')::numeric));
$$;

drop function if exists public.meu_plano();
create function public.meu_plano()
returns json language plpgsql stable security definer set search_path = '' as $$
declare uid uuid := auth.uid(); a public.assinaturas; p public.pagamentos; hoje date := public.plano_hoje();
begin
  if uid is null then raise exception 'LOGIN'; end if;
  select * into a from public.assinaturas where user_id = uid;
  select * into p from public.pagamentos where user_id = uid and status = 'pendente' order by criado_em desc limit 1;
  return json_build_object(
    'premium', public.eh_premium(uid),
    'ate', a.ate, 'origem', a.origem, 'plano', a.plano,
    'cobranca', coalesce((public.cfg('cobranca')->>'ativa')::boolean, false),
    'limites', public.cfg('limites'),
    'provas_hoje', (select count(*) from public.partidas x where x.user_id = uid and x.modo = 'classico' and x.dia = hoje),
    'cartoes_hoje', (select count(*) from public.estudo e where e.user_id = uid
                       and (e.atualizado_em at time zone 'America/Sao_Paulo')::date = hoje),
    'pendente', case when p.id is null then null
                     else json_build_object('id', p.id, 'plano', p.plano, 'valor', p.valor, 'criado_em', p.criado_em) end,
    'ultimo_recusado', (select json_build_object('plano', r.plano, 'obs', r.obs, 'em', r.decidido_em)
                          from public.pagamentos r where r.user_id = uid and r.status = 'recusado'
                            and r.decidido_em > public.plano_agora() - interval '7 days'
                            and not exists (select 1 from public.pagamentos z where z.user_id = uid and z.criado_em > r.criado_em)
                          order by r.decidido_em desc limit 1));
end $$;

-- o jogador avisa que vai pagar (ou pagou) o Pix de um plano; fica pendente até a administração confirmar
create or replace function public.solicitar_assinatura(p_plano text)
returns json language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); v numeric; m integer := public.plano_meses(p_plano); r public.pagamentos;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  if m is null then raise exception 'PLANO_INVALIDO'; end if;
  v := (public.cfg('precos')->>p_plano)::numeric;
  if v is null or v <= 0 then raise exception 'PLANO_INVALIDO'; end if;
  update public.pagamentos set status = 'cancelado', decidido_em = now(), obs = 'trocou de plano'
   where user_id = uid and status = 'pendente';
  insert into public.pagamentos (user_id, email, plano, meses, valor, tipo, status)
  values (uid, (select email from auth.users where id = uid), p_plano, m, v, 'pix', 'pendente')
  returning * into r;
  return json_build_object('id', r.id, 'plano', r.plano, 'valor', r.valor, 'criado_em', r.criado_em);
end $$;

create or replace function public.cancelar_pedido()
returns void language plpgsql security definer set search_path = '' as $$
begin
  if auth.uid() is null then raise exception 'LOGIN'; end if;
  update public.pagamentos set status = 'cancelado', decidido_em = now(), obs = 'cancelado pelo jogador'
   where user_id = auth.uid() and status = 'pendente';
end $$;

-- código de indicação de quem está logado (cria na primeira vez)
create or replace function public.meu_codigo()
returns text language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); c text;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  select codigo into c from public.codigos_indicacao where user_id = uid;
  while c is null loop
    c := upper(substr(translate(md5(random()::text || clock_timestamp()::text || uid::text), '01', ''), 1, 6));
    if length(c) < 6 or exists (select 1 from public.codigos_indicacao where codigo = c) then c := null; continue; end if;
    insert into public.codigos_indicacao (user_id, codigo) values (uid, c);
  end loop;
  return c;
end $$;

-- quem entrou por um link de indicação registra quem indicou (só contas novas, durante a promoção)
create or replace function public.registrar_indicacao(p_codigo text)
returns text language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); ind uuid; criada timestamptz;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  if not public.indicacao_ativa() then raise exception 'PROMO_ENCERRADA'; end if;
  select user_id into ind from public.codigos_indicacao where codigo = upper(trim(p_codigo));
  if ind is null then raise exception 'CODIGO_INVALIDO'; end if;
  if ind = uid then raise exception 'PROPRIO'; end if;
  if exists (select 1 from public.indicacoes where indicado = uid) then raise exception 'JA_INDICADO'; end if;
  select created_at into criada from auth.users where id = uid;
  if criada < public.plano_agora() - interval '7 days'
     or exists (select 1 from public.pagamentos where user_id = uid and status = 'confirmado' and tipo <> 'cortesia') then
    raise exception 'CONTA_ANTIGA';
  end if;
  insert into public.indicacoes (indicado, indicador) values (uid, ind);
  return coalesce((select nome from public.perfis where id = ind), 'um amigo');
end $$;

create or replace function public.minha_indicacao()
returns json language plpgsql stable security definer set search_path = '' as $$
declare uid uuid := auth.uid(); hoje date := public.plano_hoje();
begin
  if uid is null then raise exception 'LOGIN'; end if;
  return json_build_object(
    'codigo', (select codigo from public.codigos_indicacao where user_id = uid),
    'indicados', (select count(*) from public.indicacoes where indicador = uid),
    'assinantes', (select count(*) from public.indicacoes i where i.indicador = uid and public.eh_premium(i.indicado)
                     and exists (select 1 from public.pagamentos p where p.user_id = i.indicado and p.status = 'confirmado' and p.tipo <> 'cortesia')),
    'a_liberar', (select coalesce(sum(valor), 0) from public.comissoes where indicador = uid and saque_id is null and libera_em > hoje),
    'disponivel', (select coalesce(sum(valor), 0) from public.comissoes where indicador = uid and saque_id is null and libera_em <= hoje),
    'em_saque', (select coalesce(sum(valor), 0) from public.saques where user_id = uid and status = 'pendente'),
    'recebido', (select coalesce(sum(valor), 0) from public.saques where user_id = uid and status = 'pago'),
    'proxima_liberacao', (select min(libera_em) from public.comissoes where indicador = uid and saque_id is null and libera_em > hoje),
    'saques', coalesce((select json_agg(json_build_object('valor', s.valor, 'status', s.status, 'criado_em', s.criado_em,
                                                           'decidido_em', s.decidido_em, 'obs', s.obs) order by s.criado_em desc)
                          from (select * from public.saques where user_id = uid order by criado_em desc limit 10) s), '[]'::json));
end $$;

create or replace function public.solicitar_saque(p_chave text)
returns json language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); disp numeric; minimo numeric := coalesce((public.cfg('indicacao')->>'minimo')::numeric, 50); s public.saques;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  if length(trim(coalesce(p_chave, ''))) < 3 or length(p_chave) > 140 then raise exception 'CHAVE_INVALIDA'; end if;
  if exists (select 1 from public.saques where user_id = uid and status = 'pendente') then raise exception 'SAQUE_PENDENTE'; end if;
  select coalesce(sum(valor), 0) into disp from public.comissoes
   where indicador = uid and saque_id is null and libera_em <= public.plano_hoje();
  if disp < minimo then raise exception 'SALDO_MINIMO'; end if;
  insert into public.saques (user_id, email, valor, chave_pix)
  values (uid, (select email from auth.users where id = uid), disp, trim(p_chave)) returning * into s;
  update public.comissoes set saque_id = s.id
   where indicador = uid and saque_id is null and libera_em <= public.plano_hoje();
  return json_build_object('id', s.id, 'valor', s.valor);
end $$;

-- ============ administração ============
create or replace function public.admin_pagamentos(p_status text default null)
returns json language plpgsql stable security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return coalesce((select json_agg(x order by x.criado_em desc) from (
    select p.id, p.user_id, coalesce(u.email, p.email) as email, coalesce(pf.nome, '') as nome, p.plano, p.meses, p.valor,
           p.tipo, p.status, p.criado_em, p.decidido_em, d.email as decidido_por, p.obs,
           (select ui.email from public.indicacoes i join auth.users ui on ui.id = i.indicador where i.indicado = p.user_id) as indicado_por,
           (select c.valor from public.comissoes c where c.pagamento_id = p.id) as comissao
    from public.pagamentos p
    left join auth.users u on u.id = p.user_id
    left join public.perfis pf on pf.id = p.user_id
    left join auth.users d on d.id = p.decidido_por
    where p_status is null or p.status = p_status
    order by p.criado_em desc limit 2000) x), '[]'::json);
end $$;

create or replace function public.admin_confirmar_pagamento(p_id uuid)
returns json language plpgsql security definer set search_path = '' as $$
declare p public.pagamentos; v timestamptz; c numeric;
begin
  perform public.admin_exigir();
  select * into p from public.pagamentos where id = p_id for update;
  if p.id is null then raise exception 'NAO_ENCONTRADO'; end if;
  if p.status <> 'pendente' then raise exception 'JA_DECIDIDO'; end if;
  if p.user_id is null then raise exception 'CONTA_EXCLUIDA'; end if;
  update public.pagamentos set status = 'confirmado', decidido_em = now(), decidido_por = auth.uid() where id = p_id;
  v := public.premium_estender(p.user_id, p.meses, p.tipo, p.plano);
  c := public.gerar_comissao(p_id);
  return json_build_object('ate', v, 'comissao', c);
end $$;

create or replace function public.admin_recusar_pagamento(p_id uuid, p_obs text default null)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  update public.pagamentos set status = 'recusado', decidido_em = now(), decidido_por = auth.uid(), obs = nullif(trim(p_obs), '')
   where id = p_id and status = 'pendente';
  if not found then raise exception 'JA_DECIDIDO'; end if;
end $$;

-- habilita um jogador pelo e-mail: 'manual' = pagou por fora (conta para a indicação); 'cortesia' = presente, sem valor
create or replace function public.admin_habilitar(p_email text, p_plano text, p_tipo text default 'manual', p_obs text default null)
returns json language plpgsql security definer set search_path = '' as $$
declare uid uuid; m integer := public.plano_meses(p_plano); v numeric; pid uuid; ate timestamptz; c numeric;
begin
  perform public.admin_exigir();
  if m is null then raise exception 'PLANO_INVALIDO'; end if;
  if p_tipo not in ('manual', 'cortesia') then raise exception 'TIPO_INVALIDO'; end if;
  select id into uid from auth.users where lower(email) = lower(trim(p_email));
  if uid is null then raise exception 'USUARIO_NAO_ENCONTRADO'; end if;
  v := case when p_tipo = 'cortesia' then 0 else coalesce((public.cfg('precos')->>p_plano)::numeric, 0) end;
  update public.pagamentos set status = 'cancelado', decidido_em = now(), decidido_por = auth.uid(), obs = 'substituído por liberação manual'
   where user_id = uid and status = 'pendente';
  insert into public.pagamentos (user_id, email, plano, meses, valor, tipo, status, decidido_em, decidido_por, obs)
  values (uid, (select email from auth.users where id = uid), p_plano, m, v, p_tipo, 'confirmado', now(), auth.uid(), nullif(trim(p_obs), ''))
  returning id into pid;
  ate := public.premium_estender(uid, m, p_tipo, p_plano);
  c := public.gerar_comissao(pid);
  return json_build_object('ate', ate, 'comissao', c);
end $$;

create or replace function public.admin_remover_premium(p_user uuid)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  delete from public.assinaturas where user_id = p_user;
end $$;

create or replace function public.admin_assinantes()
returns json language plpgsql stable security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return coalesce((select json_agg(x order by x.ativo desc, x.ate desc) from (
    select a.user_id, u.email, coalesce(pf.nome, '') as nome, a.ate, a.origem, a.plano, a.ate > public.plano_agora() as ativo,
           (select ui.email from public.indicacoes i join auth.users ui on ui.id = i.indicador where i.indicado = a.user_id) as indicado_por,
           (select coalesce(sum(p.valor), 0) from public.pagamentos p where p.user_id = a.user_id and p.status = 'confirmado') as total_pago
    from public.assinaturas a join auth.users u on u.id = a.user_id left join public.perfis pf on pf.id = a.user_id) x), '[]'::json);
end $$;

create or replace function public.admin_indicacoes()
returns json language plpgsql stable security definer set search_path = '' as $$
declare hoje date := public.plano_hoje();
begin
  perform public.admin_exigir();
  return json_build_object(
    'resumo', coalesce((select json_agg(x order by x.indicados desc) from (
      select g.user_id, u.email, coalesce(pf.nome, '') as nome, g.codigo,
             (select count(*) from public.indicacoes i where i.indicador = g.user_id) as indicados,
             (select count(*) from public.indicacoes i where i.indicador = g.user_id and public.eh_premium(i.indicado)) as assinantes,
             (select coalesce(sum(valor), 0) from public.comissoes c where c.indicador = g.user_id and c.saque_id is null and c.libera_em > hoje) as a_liberar,
             (select coalesce(sum(valor), 0) from public.comissoes c where c.indicador = g.user_id and c.saque_id is null and c.libera_em <= hoje) as disponivel,
             (select coalesce(sum(valor), 0) from public.saques s where s.user_id = g.user_id and s.status = 'pendente') as em_saque,
             (select coalesce(sum(valor), 0) from public.saques s where s.user_id = g.user_id and s.status = 'pago') as pago
      from public.codigos_indicacao g join auth.users u on u.id = g.user_id left join public.perfis pf on pf.id = g.user_id
      where exists (select 1 from public.indicacoes i where i.indicador = g.user_id)) x), '[]'::json),
    'comissoes', coalesce((select json_agg(x order by x.criado_em desc) from (
      select c.id, ui.email as indicador, ud.email as indicado, c.valor, c.criado_em, c.libera_em, c.saque_id is not null as sacada
      from public.comissoes c left join auth.users ui on ui.id = c.indicador left join auth.users ud on ud.id = c.indicado
      order by c.criado_em desc limit 1000) x), '[]'::json),
    'saques', coalesce((select json_agg(x order by (x.status = 'pendente') desc, x.criado_em desc) from (
      select s.id, coalesce(u.email, s.email) as email, coalesce(pf.nome, '') as nome, s.valor, s.chave_pix, s.status,
             s.criado_em, s.decidido_em, d.email as decidido_por, s.obs
      from public.saques s left join auth.users u on u.id = s.user_id left join public.perfis pf on pf.id = s.user_id
      left join auth.users d on d.id = s.decidido_por
      order by s.criado_em desc limit 1000) x), '[]'::json));
end $$;

create or replace function public.admin_decidir_saque(p_id uuid, p_pago boolean, p_obs text default null)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  update public.saques set status = case when p_pago then 'pago' else 'recusado' end,
         decidido_em = now(), decidido_por = auth.uid(), obs = nullif(trim(p_obs), '')
   where id = p_id and status = 'pendente';
  if not found then raise exception 'JA_DECIDIDO'; end if;
  -- recusado: o valor volta para o saldo de quem pediu
  if not p_pago then update public.comissoes set saque_id = null where saque_id = p_id; end if;
end $$;

create or replace function public.admin_config()
returns json language plpgsql stable security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return json_build_object(
    'config', (select json_object_agg(c.chave, c.valor) from public.config c),
    'admins', coalesce((select json_agg(json_build_object('user_id', a.user_id, 'email', u.email, 'nome', pf.nome, 'eu', a.user_id = auth.uid()) order by a.criado_em)
                          from public.admins a join auth.users u on u.id = a.user_id left join public.perfis pf on pf.id = a.user_id), '[]'::json));
end $$;

create or replace function public.admin_salvar_config(p_chave text, p_valor jsonb)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  if p_chave not in ('cobranca', 'limites', 'precos', 'pix', 'emails', 'indicacao') then raise exception 'CHAVE_INVALIDA'; end if;
  if p_chave = 'emails' and jsonb_typeof(p_valor) <> 'array' then raise exception 'VALOR_INVALIDO'; end if;
  if p_chave <> 'emails' and jsonb_typeof(p_valor) <> 'object' then raise exception 'VALOR_INVALIDO'; end if;
  if p_chave = 'precos' and exists (select 1 from jsonb_each_text(p_valor) e
        where e.key not in ('mensal', 'trimestral', 'semestral', 'anual') or e.value::numeric < 0) then raise exception 'VALOR_INVALIDO'; end if;
  insert into public.config (chave, valor, atualizado_em) values (p_chave, p_valor, now())
  on conflict (chave) do update set valor = excluded.valor, atualizado_em = now();
end $$;

create or replace function public.admin_adicionar_admin(p_email text)
returns void language plpgsql security definer set search_path = '' as $$
declare uid uuid;
begin
  perform public.admin_exigir();
  select id into uid from auth.users where lower(email) = lower(trim(p_email));
  if uid is null then raise exception 'USUARIO_NAO_ENCONTRADO'; end if;
  insert into public.admins (user_id) values (uid) on conflict do nothing;
end $$;

create or replace function public.admin_remover_admin(p_user uuid)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  if p_user = auth.uid() then raise exception 'NAO_PODE_SI'; end if;
  delete from public.admins where user_id = p_user;
  if not exists (select 1 from public.admins) then raise exception 'ULTIMO_ADMIN'; end if;
end $$;

-- ============ permissões ============
revoke all on function public.plano_agora(), public.plano_hoje(), public.cfg(text), public.plano_meses(text), public.indicacao_ativa(),
  public.comissao_libera_em(timestamptz), public.eh_premium(uuid), public.premium_estender(uuid, integer, text, text),
  public.gerar_comissao(uuid) from public, anon, authenticated;

revoke all on function public.plano_info() from public;
grant execute on function public.plano_info() to anon, authenticated;

revoke all on function public.meu_plano(), public.solicitar_assinatura(text), public.cancelar_pedido(), public.meu_codigo(),
  public.registrar_indicacao(text), public.minha_indicacao(), public.solicitar_saque(text),
  public.admin_pagamentos(text), public.admin_confirmar_pagamento(uuid), public.admin_recusar_pagamento(uuid, text),
  public.admin_habilitar(text, text, text, text), public.admin_remover_premium(uuid), public.admin_assinantes(),
  public.admin_indicacoes(), public.admin_decidir_saque(uuid, boolean, text), public.admin_config(),
  public.admin_salvar_config(text, jsonb), public.admin_adicionar_admin(text), public.admin_remover_admin(uuid) from public, anon;
grant execute on function public.meu_plano(), public.solicitar_assinatura(text), public.cancelar_pedido(), public.meu_codigo(),
  public.registrar_indicacao(text), public.minha_indicacao(), public.solicitar_saque(text),
  public.admin_pagamentos(text), public.admin_confirmar_pagamento(uuid), public.admin_recusar_pagamento(uuid, text),
  public.admin_habilitar(text, text, text, text), public.admin_remover_premium(uuid), public.admin_assinantes(),
  public.admin_indicacoes(), public.admin_decidir_saque(uuid, boolean, text), public.admin_config(),
  public.admin_salvar_config(text, jsonb), public.admin_adicionar_admin(text), public.admin_remover_admin(uuid) to authenticated;

select 'plano pago pronto' as status,
       (select count(*) from public.assinaturas where origem = 'fundador') as contas_com_3_meses_de_presente,
       (select count(*) from public.admins) as administradores;
