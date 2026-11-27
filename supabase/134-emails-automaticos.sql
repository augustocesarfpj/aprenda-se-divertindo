-- Aprenda se Divertindo · 134 · E-mails automáticos (fila no banco)
-- Rode depois do 132-ranking-simulado-situacao.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Cria a fila de e-mails. O banco só ANOTA o que precisa ser enviado; quem envia é o robô do
-- repositório privado aprenda-backup (workflow "E-mails automáticos", a cada 30 minutos), pelo Gmail.
-- Enquanto o Gmail não estiver configurado lá, nada é enviado e nada quebra.
--
-- Entram na fila:
--   • para o jogador: "Premium ativado" (pagamento confirmado ou cortesia), "seu Premium vence em 3 dias" e "seu Premium venceu";
--   • para vocês (e-mails de notificação das Configurações do admin), num resumo único por rodada:
--     pagamento confirmado, Pix aguardando confirmação manual, pedido de saque, erro reportado e cadastro novo.
-- Também cria a chave "emails_auto" nas Configurações: quando ligada, o "Esqueci minha senha" do jogo passa a
-- mandar o link de nova senha direto para o jogador (depende do Gmail configurado no Supabase, ver README).

create table if not exists public.emails_fila (
  id          bigint generated always as identity primary key,
  tipo        text not null,               -- 'jogador' ou 'admin'
  user_id     uuid references auth.users (id) on delete cascade,
  assunto     text not null,
  corpo       text not null,
  chave       text unique,                 -- evita e-mail repetido do mesmo evento
  criado_em   timestamptz not null default now(),
  enviado_em  timestamptz,
  erro        text
);
create index if not exists emails_fila_pendentes on public.emails_fila (criado_em) where enviado_em is null and erro is null;
alter table public.emails_fila enable row level security;
revoke all on public.emails_fila from public, anon, authenticated;

create or replace function public.email_anotar(p_tipo text, p_user uuid, p_assunto text, p_corpo text, p_chave text)
returns void language sql security definer set search_path = '' as $$
  insert into public.emails_fila (tipo, user_id, assunto, corpo, chave)
  values (p_tipo, p_user, p_assunto, p_corpo, p_chave)
  on conflict (chave) do nothing;
$$;

-- to_char usa o padrão do servidor (vírgula para milhar, ponto para decimal): troca para o jeito brasileiro
create or replace function public.email_reais(v numeric)
returns text language sql immutable set search_path = '' as $$
  select 'R$ ' || translate(to_char(coalesce(v, 0), 'FM999,990.00'), ',.', '.,');
$$;

-- pagamentos: Premium ativado (jogador), pagamento confirmado e Pix manual aguardando (admin)
create or replace function public.email_pagamento()
returns trigger language plpgsql security definer set search_path = '' as $$
declare pl text := case new.plano when 'mensal' then 'Mensal' when 'trimestral' then 'Trimestral'
                                  when 'semestral' then 'Semestral' when 'anual' then 'Anual' else new.plano end;
begin
  if new.status = 'confirmado' and (tg_op = 'INSERT' or old.status is distinct from 'confirmado') then
    if new.user_id is not null then
      perform public.email_anotar('jogador', new.user_id,
        'Seu Premium está ativo · Aprenda se Divertindo',
        'Olá, {nome}!' || chr(10) || chr(10) ||
        case when new.tipo = 'cortesia' or new.valor = 0
             then 'Liberamos o plano Premium ' || pl || ' na sua conta, de presente.'
             else 'Recebemos o seu Pix de ' || public.email_reais(new.valor) || ' e o plano Premium ' || pl || ' já está ativo na sua conta.' end
        || chr(10) || 'Seu Premium vale até {ate}.' || chr(10) || chr(10) ||
        'Com ele você tem provas e cartões de estudo sem limite e os simulados de fim de semana.' || chr(10) ||
        'Bons estudos!' || chr(10) || 'https://aprendasedivertindo.com.br',
        'premium:' || new.id);
    end if;
    if new.valor > 0 then
      perform public.email_anotar('admin', null,
        'Pagamento confirmado',
        public.email_reais(new.valor) || ' · plano ' || pl || ' · ' || coalesce(new.email, '(sem e-mail)') ||
        coalesce(' · via ' || new.gateway, ''),
        'adm-pag:' || new.id);
    end if;
  elsif tg_op = 'INSERT' and new.status = 'pendente' and new.tipo = 'pix' and new.gateway is null then
    perform public.email_anotar('admin', null,
      'Pix aguardando confirmação manual',
      public.email_reais(new.valor) || ' · plano ' || pl || ' · ' || coalesce(new.email, '(sem e-mail)') ||
      ' · confira o comprovante e confirme na aba Pagamentos do admin.',
      'adm-pend:' || new.id);
  end if;
  return null;
end $$;
drop trigger if exists email_pagamento on public.pagamentos;
create trigger email_pagamento after insert or update of status on public.pagamentos
  for each row execute function public.email_pagamento();

create or replace function public.email_saque()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
  perform public.email_anotar('admin', null, 'Pedido de saque',
    public.email_reais(new.valor) || ' · ' || coalesce(new.email, '(sem e-mail)') || ' · pague e marque como pago na aba Indicações do admin.',
    'adm-saque:' || new.id);
  return null;
end $$;
drop trigger if exists email_saque on public.saques;
create trigger email_saque after insert on public.saques
  for each row execute function public.email_saque();

create or replace function public.email_erro()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
  perform public.email_anotar('admin', null, 'Erro reportado',
    'Em ' || new.origem || ' nº ' || new.ref_id || coalesce(' (questão ' || new.ordem || ')', '') || ' · motivo: ' || new.motivo ||
    case when new.comentario <> '' then ' · "' || left(new.comentario, 200) || '"' else '' end,
    'adm-erro:' || new.id);
  return null;
end $$;
drop trigger if exists email_erro on public.erros_reportados;
create trigger email_erro after insert on public.erros_reportados
  for each row execute function public.email_erro();

create or replace function public.email_cadastro()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
  perform public.email_anotar('admin', null, 'Cadastro novo', new.nome, 'adm-cad:' || new.id);
  return null;
end $$;
drop trigger if exists email_cadastro on public.perfis;
create trigger email_cadastro after insert on public.perfis
  for each row execute function public.email_cadastro();

-- vencimentos: o robô chama esta função a cada rodada
create or replace function public.emails_vencimentos()
returns void language plpgsql security definer set search_path = '' as $$
declare a record;
begin
  for a in select s.user_id, s.ate from public.assinaturas s
            where s.ate between now() + interval '2 days' and now() + interval '3 days' loop
    perform public.email_anotar('jogador', a.user_id, 'Seu Premium vence em 3 dias · Aprenda se Divertindo',
      'Olá, {nome}!' || chr(10) || chr(10) ||
      'Seu Premium vence em {ate}. Depois disso, a conta volta para o plano grátis (5 provas e 5 cartões por dia, sem simulados).' || chr(10) ||
      'O pagamento é único, por Pix, sem renovação automática: para continuar, é só renovar no jogo, em Minha conta → Premium.' || chr(10) || chr(10) ||
      'https://aprendasedivertindo.com.br',
      'vence3:' || a.user_id || ':' || (a.ate at time zone 'America/Sao_Paulo')::date);
  end loop;
  for a in select s.user_id, s.ate from public.assinaturas s
            where s.ate between now() - interval '1 day' and now() loop
    perform public.email_anotar('jogador', a.user_id, 'Seu Premium venceu · Aprenda se Divertindo',
      'Olá, {nome}!' || chr(10) || chr(10) ||
      'Seu Premium venceu hoje, e a conta voltou para o plano grátis. Seu progresso continua salvo.' || chr(10) ||
      'Quando quiser voltar a ter provas sem limite e os simulados de fim de semana, renove no jogo, em Minha conta → Premium.' || chr(10) || chr(10) ||
      'https://aprendasedivertindo.com.br',
      'venceu:' || a.user_id || ':' || (a.ate at time zone 'America/Sao_Paulo')::date);
  end loop;
end $$;

revoke all on function public.email_anotar(text, uuid, text, text, text), public.email_pagamento(), public.email_saque(),
  public.email_erro(), public.email_cadastro(), public.emails_vencimentos() from public, anon, authenticated;

-- ============ chave "emails_auto" nas Configurações + plano_info ============
create or replace function public.plano_info()
returns json language sql stable security definer set search_path = '' as $$
  select json_build_object(
    'cobranca',    coalesce((public.cfg('cobranca')->>'ativa')::boolean, false),
    'limites',     public.cfg('limites'),
    'precos',      public.cfg('precos'),
    'pix',         public.cfg('pix'),
    'emails',      public.cfg('emails'),
    'pagbank',     coalesce((public.cfg('pagbank')->>'ativo')::boolean, false),
    'mercadopago', coalesce((public.cfg('mercadopago')->>'ativo')::boolean, false),
    'captcha',     nullif(public.cfg('captcha')->>'sitekey', ''),
    'senha_auto',  coalesce((public.cfg('emails_auto')->>'senha')::boolean, false),
    'indicacao',   json_build_object('ativa', public.indicacao_ativa(),
                                     'fim', nullif(public.cfg('indicacao')->>'fim', ''),
                                     'valor', (public.cfg('indicacao')->>'valor')::numeric,
                                     'minimo', (public.cfg('indicacao')->>'minimo')::numeric));
$$;

create or replace function public.admin_salvar_config(p_chave text, p_valor jsonb)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  if p_chave not in ('cobranca', 'limites', 'precos', 'pix', 'emails', 'indicacao', 'pagbank', 'mercadopago', 'captcha', 'emails_auto') then raise exception 'CHAVE_INVALIDA'; end if;
  if p_chave = 'emails' and jsonb_typeof(p_valor) <> 'array' then raise exception 'VALOR_INVALIDO'; end if;
  if p_chave <> 'emails' and jsonb_typeof(p_valor) <> 'object' then raise exception 'VALOR_INVALIDO'; end if;
  if p_chave = 'precos' and exists (select 1 from jsonb_each_text(p_valor) e
        where e.key not in ('mensal', 'trimestral', 'semestral', 'anual') or e.value::numeric < 0) then raise exception 'VALOR_INVALIDO'; end if;
  if p_chave = 'captcha' and coalesce(p_valor->>'sitekey', '') !~ '^(0x[A-Za-z0-9_-]{10,60})?$' then raise exception 'VALOR_INVALIDO'; end if;
  insert into public.config (chave, valor, atualizado_em) values (p_chave, p_valor, now())
  on conflict (chave) do update set valor = excluded.valor, atualizado_em = now();
end $$;

insert into public.config (chave, valor) values ('emails_auto', '{"jogador": true, "admin": true, "senha": false}')
on conflict (chave) do nothing;

-- resumo da fila para o admin (só administradores)
create or replace function public.admin_emails_fila()
returns json language plpgsql stable security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return json_build_object(
    'pendentes', (select count(*) from public.emails_fila where enviado_em is null and erro is null),
    'enviados_7d', (select count(*) from public.emails_fila where enviado_em > now() - interval '7 days'),
    'ultimo_envio', (select max(enviado_em) from public.emails_fila),
    'erros_7d', (select count(*) from public.emails_fila where erro is not null and erro <> 'expirado' and criado_em > now() - interval '7 days'));
end $$;
revoke execute on function public.admin_emails_fila() from public, anon;
grant execute on function public.admin_emails_fila() to authenticated;

select 'fila de e-mails pronta' as status, public.cfg('emails') as avisos_para, public.cfg('emails_auto') as configuracao;
