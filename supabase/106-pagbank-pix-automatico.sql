-- Aprenda se Divertindo · 106 · Pix automático pelo PagBank (PagSeguro)
-- Rode depois do 105-trilha-policial-16.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- O que este arquivo faz:
--   • Guarda, em cada pagamento, o pedido do PagBank e o Pix copia e cola gerado por ele.
--   • Cria as funções que só a função "pagbank-pix" (Edge Function, com a chave service_role) pode chamar:
--     registrar o Pix gerado e confirmar o pagamento quando o PagBank avisa que foi pago.
--     A confirmação libera o Premium e a comissão da indicação na hora, sem precisar da administração.
--   • Liga/desliga pela administração (Configurações → PagBank). Começa DESLIGADO: o Pix manual continua igual
--     até você publicar a função e ligar a chave.
--   • O CPF do jogador vai só para o PagBank (é obrigatório lá). Ele NÃO é guardado no banco do jogo.

insert into public.config (chave, valor) values ('pagbank', '{"ativo": false}')
on conflict (chave) do nothing;

alter table public.pagamentos add column if not exists gateway    text;
alter table public.pagamentos add column if not exists gateway_id text;
alter table public.pagamentos add column if not exists pix_copia  text;
alter table public.pagamentos add column if not exists pix_qr     text;
alter table public.pagamentos add column if not exists pix_expira timestamptz;
alter table public.pagamentos add column if not exists pago_em    timestamptz;
create unique index if not exists pagamentos_gateway_id on public.pagamentos (gateway_id) where gateway_id is not null;

-- ============ só para a Edge Function (service_role) ============
-- cria o pedido pendente do jogador (cancela o pendente anterior) e devolve id e valor em centavos
create or replace function public.pagbank_novo_pedido(p_user uuid, p_plano text)
returns json language plpgsql security definer set search_path = '' as $$
declare v numeric; m integer := public.plano_meses(p_plano); r public.pagamentos;
begin
  if p_user is null then raise exception 'LOGIN'; end if;
  if not coalesce((public.cfg('pagbank')->>'ativo')::boolean, false) then raise exception 'PAGBANK_DESLIGADO'; end if;
  if m is null then raise exception 'PLANO_INVALIDO'; end if;
  v := (public.cfg('precos')->>p_plano)::numeric;
  if v is null or v <= 0 then raise exception 'PLANO_INVALIDO'; end if;
  update public.pagamentos set status = 'cancelado', decidido_em = now(), obs = 'trocou de plano'
   where user_id = p_user and status = 'pendente';
  insert into public.pagamentos (user_id, email, plano, meses, valor, tipo, status, gateway)
  values (p_user, (select email from auth.users where id = p_user), p_plano, m, v, 'pix', 'pendente', 'pagbank')
  returning * into r;
  return json_build_object('id', r.id, 'plano', r.plano, 'valor', r.valor, 'centavos', round(r.valor * 100)::int,
                           'email', r.email, 'nome', (select nullif(trim(pf.nome), '') from public.perfis pf where pf.id = p_user));
end $$;

create or replace function public.pagbank_registrar(p_id uuid, p_order text, p_copia text, p_qr text, p_expira timestamptz)
returns void language plpgsql security definer set search_path = '' as $$
begin
  update public.pagamentos set gateway_id = p_order, pix_copia = p_copia, pix_qr = p_qr, pix_expira = p_expira
   where id = p_id and gateway = 'pagbank';
end $$;

-- confirma (uma vez só) o pagamento que o PagBank disse estar pago, conferindo o valor em centavos
create or replace function public.pagbank_confirmar(p_order text, p_centavos integer)
returns json language plpgsql security definer set search_path = '' as $$
declare p public.pagamentos; v timestamptz; c numeric;
begin
  select * into p from public.pagamentos where gateway_id = p_order for update;
  if p.id is null then return json_build_object('ok', false, 'motivo', 'NAO_ENCONTRADO'); end if;
  if p.status = 'confirmado' then return json_build_object('ok', true, 'ja', true); end if;
  if p_centavos is null or p_centavos < round(p.valor * 100) then
    update public.pagamentos set obs = 'PagBank: valor pago (' || coalesce(p_centavos::text, '?') || ' centavos) diferente do plano' where id = p.id;
    return json_build_object('ok', false, 'motivo', 'VALOR');
  end if;
  if p.user_id is null then return json_build_object('ok', false, 'motivo', 'CONTA_EXCLUIDA'); end if;
  -- mesmo que o jogador tenha trocado de plano ou cancelado, se o dinheiro entrou o Premium é liberado
  update public.pagamentos set status = 'confirmado', decidido_em = now(), pago_em = now(), obs = 'PagBank automático'
   where id = p.id;
  update public.pagamentos set status = 'cancelado', decidido_em = now(), obs = 'outro pedido foi pago'
   where user_id = p.user_id and status = 'pendente' and id <> p.id;
  v := public.premium_estender(p.user_id, p.meses, 'pagbank', p.plano);
  c := public.gerar_comissao(p.id);
  return json_build_object('ok', true, 'ate', v, 'comissao', c);
end $$;

-- o pedido PagBank pendente do jogador (a Edge Function usa para conferir o status quando o site pergunta)
create or replace function public.pagbank_pedido_do(p_user uuid)
returns json language sql stable security definer set search_path = '' as $$
  select json_build_object('id', p.id, 'order', p.gateway_id, 'status', p.status)
  from public.pagamentos p where p.user_id = p_user and p.gateway = 'pagbank' and p.gateway_id is not null
  order by p.criado_em desc limit 1;
$$;

revoke all on function public.pagbank_novo_pedido(uuid, text) from public, anon, authenticated;
revoke all on function public.pagbank_registrar(uuid, text, text, text, timestamptz) from public, anon, authenticated;
revoke all on function public.pagbank_confirmar(text, integer) from public, anon, authenticated;
revoke all on function public.pagbank_pedido_do(uuid) from public, anon, authenticated;
grant execute on function public.pagbank_novo_pedido(uuid, text) to service_role;
grant execute on function public.pagbank_registrar(uuid, text, text, text, timestamptz) to service_role;
grant execute on function public.pagbank_confirmar(text, integer) to service_role;
grant execute on function public.pagbank_pedido_do(uuid) to service_role;

-- ============ para o jogador ============
create or replace function public.plano_info()
returns json language sql stable security definer set search_path = '' as $$
  select json_build_object(
    'cobranca',  coalesce((public.cfg('cobranca')->>'ativa')::boolean, false),
    'limites',   public.cfg('limites'),
    'precos',    public.cfg('precos'),
    'pix',       public.cfg('pix'),
    'emails',    public.cfg('emails'),
    'pagbank',   coalesce((public.cfg('pagbank')->>'ativo')::boolean, false),
    'indicacao', json_build_object('ativa', public.indicacao_ativa(),
                                   'fim', nullif(public.cfg('indicacao')->>'fim', ''),
                                   'valor', (public.cfg('indicacao')->>'valor')::numeric,
                                   'minimo', (public.cfg('indicacao')->>'minimo')::numeric));
$$;

-- meu_plano passa a devolver também o Pix do PagBank do pedido pendente
create or replace function public.meu_plano()
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
                     else json_build_object('id', p.id, 'plano', p.plano, 'valor', p.valor, 'criado_em', p.criado_em,
                                            'gateway', p.gateway, 'pix_copia', p.pix_copia, 'pix_qr', p.pix_qr, 'pix_expira', p.pix_expira) end,
    'ultimo_recusado', (select json_build_object('plano', r.plano, 'obs', r.obs, 'em', r.decidido_em)
                          from public.pagamentos r where r.user_id = uid and r.status = 'recusado'
                            and r.decidido_em > public.plano_agora() - interval '7 days'
                            and not exists (select 1 from public.pagamentos z where z.user_id = uid and z.criado_em > r.criado_em)
                          order by r.decidido_em desc limit 1));
end $$;

-- ============ administração: aceita a chave 'pagbank' ============
create or replace function public.admin_salvar_config(p_chave text, p_valor jsonb)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  if p_chave not in ('cobranca', 'limites', 'precos', 'pix', 'emails', 'indicacao', 'pagbank') then raise exception 'CHAVE_INVALIDA'; end if;
  if p_chave = 'emails' and jsonb_typeof(p_valor) <> 'array' then raise exception 'VALOR_INVALIDO'; end if;
  if p_chave <> 'emails' and jsonb_typeof(p_valor) <> 'object' then raise exception 'VALOR_INVALIDO'; end if;
  if p_chave = 'precos' and exists (select 1 from jsonb_each_text(p_valor) e
        where e.key not in ('mensal', 'trimestral', 'semestral', 'anual') or e.value::numeric < 0) then raise exception 'VALOR_INVALIDO'; end if;
  insert into public.config (chave, valor, atualizado_em) values (p_chave, p_valor, now())
  on conflict (chave) do update set valor = excluded.valor, atualizado_em = now();
end $$;
