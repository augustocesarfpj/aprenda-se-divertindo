-- Aprenda se Divertindo · 117 · Pix automático pelo Mercado Pago
-- Rode depois do 116-simulado-desafio-pcba.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- O que este arquivo faz:
--   • Cria as funções que só a Edge Function "mercadopago-pix" (com a chave service_role) pode chamar:
--     criar o pedido, registrar o Pix gerado e confirmar o pagamento quando o Mercado Pago avisa que foi pago.
--     A confirmação libera o Premium e a comissão da indicação na hora, sem precisar da administração.
--   • Liga/desliga pela administração (Configurações → Pix automático (Mercado Pago)). Começa DESLIGADO.
--   • Se o Mercado Pago e o PagBank estiverem ligados ao mesmo tempo, o jogo usa o Mercado Pago.
--   • O CPF do jogador vai só para o Mercado Pago. Ele NÃO é guardado no banco do jogo.
--   • O PagBank continua como está (arquivo 106).

insert into public.config (chave, valor) values ('mercadopago', '{"ativo": false}')
on conflict (chave) do nothing;

-- ============ só para a Edge Function (service_role) ============
create or replace function public.mp_novo_pedido(p_user uuid, p_plano text)
returns json language plpgsql security definer set search_path = '' as $$
declare v numeric; m integer := public.plano_meses(p_plano); r public.pagamentos;
begin
  if p_user is null then raise exception 'LOGIN'; end if;
  if not coalesce((public.cfg('mercadopago')->>'ativo')::boolean, false) then raise exception 'MP_DESLIGADO'; end if;
  if m is null then raise exception 'PLANO_INVALIDO'; end if;
  v := (public.cfg('precos')->>p_plano)::numeric;
  if v is null or v <= 0 then raise exception 'PLANO_INVALIDO'; end if;
  update public.pagamentos set status = 'cancelado', decidido_em = now(), obs = 'trocou de plano'
   where user_id = p_user and status = 'pendente';
  insert into public.pagamentos (user_id, email, plano, meses, valor, tipo, status, gateway)
  values (p_user, (select email from auth.users where id = p_user), p_plano, m, v, 'pix', 'pendente', 'mercadopago')
  returning * into r;
  return json_build_object('id', r.id, 'plano', r.plano, 'valor', r.valor, 'centavos', round(r.valor * 100)::int,
                           'email', r.email, 'nome', (select nullif(trim(pf.nome), '') from public.perfis pf where pf.id = p_user));
end $$;

create or replace function public.mp_registrar(p_id uuid, p_pagamento text, p_copia text, p_qr text, p_expira timestamptz)
returns void language plpgsql security definer set search_path = '' as $$
begin
  update public.pagamentos set gateway_id = 'mp_' || p_pagamento, pix_copia = p_copia, pix_qr = p_qr, pix_expira = p_expira
   where id = p_id and gateway = 'mercadopago';
end $$;

-- confirma (uma vez só) o pagamento que o Mercado Pago disse estar aprovado, conferindo o valor em centavos
create or replace function public.mp_confirmar(p_pagamento text, p_centavos integer)
returns json language plpgsql security definer set search_path = '' as $$
declare p public.pagamentos; v timestamptz; c numeric;
begin
  select * into p from public.pagamentos where gateway_id = 'mp_' || p_pagamento for update;
  if p.id is null then return json_build_object('ok', false, 'motivo', 'NAO_ENCONTRADO'); end if;
  if p.status = 'confirmado' then return json_build_object('ok', true, 'ja', true); end if;
  if p_centavos is null or p_centavos < round(p.valor * 100) then
    update public.pagamentos set obs = 'Mercado Pago: valor pago (' || coalesce(p_centavos::text, '?') || ' centavos) diferente do plano' where id = p.id;
    return json_build_object('ok', false, 'motivo', 'VALOR');
  end if;
  if p.user_id is null then return json_build_object('ok', false, 'motivo', 'CONTA_EXCLUIDA'); end if;
  update public.pagamentos set status = 'confirmado', decidido_em = now(), pago_em = now(), obs = 'Mercado Pago automático'
   where id = p.id;
  update public.pagamentos set status = 'cancelado', decidido_em = now(), obs = 'outro pedido foi pago'
   where user_id = p.user_id and status = 'pendente' and id <> p.id;
  v := public.premium_estender(p.user_id, p.meses, 'mercadopago', p.plano);
  c := public.gerar_comissao(p.id);
  return json_build_object('ok', true, 'ate', v, 'comissao', c);
end $$;

create or replace function public.mp_pedido_do(p_user uuid)
returns json language sql stable security definer set search_path = '' as $$
  select json_build_object('id', p.id, 'pagamento', substr(p.gateway_id, 4), 'status', p.status)
  from public.pagamentos p where p.user_id = p_user and p.gateway = 'mercadopago' and p.gateway_id is not null
  order by p.criado_em desc limit 1;
$$;

revoke all on function public.mp_novo_pedido(uuid, text) from public, anon, authenticated;
revoke all on function public.mp_registrar(uuid, text, text, text, timestamptz) from public, anon, authenticated;
revoke all on function public.mp_confirmar(text, integer) from public, anon, authenticated;
revoke all on function public.mp_pedido_do(uuid) from public, anon, authenticated;
grant execute on function public.mp_novo_pedido(uuid, text) to service_role;
grant execute on function public.mp_registrar(uuid, text, text, text, timestamptz) to service_role;
grant execute on function public.mp_confirmar(text, integer) to service_role;
grant execute on function public.mp_pedido_do(uuid) to service_role;

-- ============ para o jogador: informa se o Mercado Pago está ligado ============
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
    'indicacao',   json_build_object('ativa', public.indicacao_ativa(),
                                     'fim', nullif(public.cfg('indicacao')->>'fim', ''),
                                     'valor', (public.cfg('indicacao')->>'valor')::numeric,
                                     'minimo', (public.cfg('indicacao')->>'minimo')::numeric));
$$;

-- ============ administração: aceita a chave 'mercadopago' ============
create or replace function public.admin_salvar_config(p_chave text, p_valor jsonb)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  if p_chave not in ('cobranca', 'limites', 'precos', 'pix', 'emails', 'indicacao', 'pagbank', 'mercadopago') then raise exception 'CHAVE_INVALIDA'; end if;
  if p_chave = 'emails' and jsonb_typeof(p_valor) <> 'array' then raise exception 'VALOR_INVALIDO'; end if;
  if p_chave <> 'emails' and jsonb_typeof(p_valor) <> 'object' then raise exception 'VALOR_INVALIDO'; end if;
  if p_chave = 'precos' and exists (select 1 from jsonb_each_text(p_valor) e
        where e.key not in ('mensal', 'trimestral', 'semestral', 'anual') or e.value::numeric < 0) then raise exception 'VALOR_INVALIDO'; end if;
  insert into public.config (chave, valor, atualizado_em) values (p_chave, p_valor, now())
  on conflict (chave) do update set valor = excluded.valor, atualizado_em = now();
end $$;
