-- Aprenda se Divertindo · 130 · CAPTCHA no login/cadastro e trava contra robôs no contador
-- Rode depois do 129-limites-no-servidor.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- PARTE 1 · CAPTCHA (Cloudflare Turnstile, grátis)
--   A página de administração ganha o campo "Chave do site" do Turnstile (é pública, aparece no site).
--   Quando ela está salva, o jogo e o admin mostram o CAPTCHA no Entrar e no Criar conta.
--   A chave secreta do Turnstile NÃO vem para cá: ela vai só no painel do Supabase.
--
-- PARTE 2 · Contador de visitas e partidas sem conta
--   Um robô conseguia encher o banco criando visitas e partidas falsas sem login.
--   Agora, acima destes limites por dia, o banco simplesmente ignora o registro (sem erro na tela):
--   • visitas: 20.000 por dia no total;
--   • partidas sem conta: 100 por aparelho e 30.000 no total.

-- ============ PARTE 1 ============
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
    'indicacao',   json_build_object('ativa', public.indicacao_ativa(),
                                     'fim', nullif(public.cfg('indicacao')->>'fim', ''),
                                     'valor', (public.cfg('indicacao')->>'valor')::numeric,
                                     'minimo', (public.cfg('indicacao')->>'minimo')::numeric));
$$;

create or replace function public.admin_salvar_config(p_chave text, p_valor jsonb)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  if p_chave not in ('cobranca', 'limites', 'precos', 'pix', 'emails', 'indicacao', 'pagbank', 'mercadopago', 'captcha') then raise exception 'CHAVE_INVALIDA'; end if;
  if p_chave = 'emails' and jsonb_typeof(p_valor) <> 'array' then raise exception 'VALOR_INVALIDO'; end if;
  if p_chave <> 'emails' and jsonb_typeof(p_valor) <> 'object' then raise exception 'VALOR_INVALIDO'; end if;
  if p_chave = 'precos' and exists (select 1 from jsonb_each_text(p_valor) e
        where e.key not in ('mensal', 'trimestral', 'semestral', 'anual') or e.value::numeric < 0) then raise exception 'VALOR_INVALIDO'; end if;
  -- só a chave pública do site (começa com 0x); vazio desliga o CAPTCHA no site
  if p_chave = 'captcha' and coalesce(p_valor->>'sitekey', '') !~ '^(0x[A-Za-z0-9_-]{10,60})?$' then raise exception 'VALOR_INVALIDO'; end if;
  insert into public.config (chave, valor, atualizado_em) values (p_chave, p_valor, now())
  on conflict (chave) do update set valor = excluded.valor, atualizado_em = now();
end $$;

-- ============ PARTE 2 ============
create index if not exists visitas_dia on public.visitas (dia);
create index if not exists partidas_anonimas_aparelho on public.partidas_anonimas (aparelho, dia);

create or replace function public.visita_limite()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
  if (select count(*) from public.visitas where dia = new.dia) >= 20000 then return null; end if;
  return new;
end $$;
drop trigger if exists visita_limite on public.visitas;
create trigger visita_limite before insert on public.visitas
  for each row execute function public.visita_limite();

create or replace function public.partida_anonima_limite()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
  if (select count(*) from public.partidas_anonimas where aparelho = new.aparelho and dia = new.dia) >= 100 then return null; end if;
  if (select count(*) from public.partidas_anonimas where dia = new.dia) >= 30000 then return null; end if;
  return new;
end $$;
drop trigger if exists partida_anonima_limite on public.partidas_anonimas;
create trigger partida_anonima_limite before insert on public.partidas_anonimas
  for each row execute function public.partida_anonima_limite();

revoke all on function public.visita_limite(), public.partida_anonima_limite() from public, anon, authenticated;

select 'CAPTCHA pronto para configurar e contador protegido' as status,
       coalesce(public.cfg('captcha')->>'sitekey', '(sem chave ainda)') as chave_do_site,
       (select count(*) from public.visitas where dia = (now() at time zone 'America/Sao_Paulo')::date) as visitas_hoje;
