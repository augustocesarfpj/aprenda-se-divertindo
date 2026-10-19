-- Aprenda se Divertindo · 75 · Reportar erro (questões do jogo, cartões de estudo e simulados)
-- Rode depois do 74-cartoes-policial.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- O jogador toca em "Reportar erro", escolhe o motivo e, se quiser, escreve um detalhe.
-- Os avisos aparecem na aba "Erros reportados" do admin.html, junto com o conteúdo atual do item,
-- para corrigir, desativar, marcar como resolvido ou descartar.
-- Limites contra abuso: 30 avisos por pessoa a cada 24 horas e um aviso aberto por item para cada pessoa.

create table if not exists public.erros_reportados (
  id            bigint generated always as identity primary key,
  user_id       uuid references auth.users (id) on delete set null,
  origem        text not null check (origem in ('questao', 'cartao', 'simulado')),
  ref_id        bigint not null,
  ordem         smallint,
  motivo        text not null check (motivo in ('resposta', 'desatualizada', 'confusa', 'outro')),
  comentario    text not null default '' check (char_length(comentario) <= 500),
  trecho        text not null default '' check (char_length(trecho) <= 600),
  status        text not null default 'aberto' check (status in ('aberto', 'resolvido', 'descartado')),
  criado_em     timestamptz not null default now(),
  resolvido_em  timestamptz,
  resolvido_por uuid
);
create index if not exists erros_status on public.erros_reportados (status, criado_em desc);
create index if not exists erros_item on public.erros_reportados (origem, ref_id, ordem);
alter table public.erros_reportados enable row level security;
revoke all on public.erros_reportados from anon, authenticated;

-- ============ jogador ============
create or replace function public.reportar_erro(p_origem text, p_ref bigint, p_ordem integer, p_motivo text, p_comentario text, p_trecho text)
returns void language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid();
begin
  if p_origem not in ('questao', 'cartao', 'simulado') or p_motivo not in ('resposta', 'desatualizada', 'confusa', 'outro') or p_ref is null then
    raise exception 'DADOS_INVALIDOS';
  end if;
  if uid is null then
    if (select count(*) from public.erros_reportados where user_id is null and criado_em > now() - interval '1 day') >= 300 then raise exception 'LIMITE'; end if;
  else
    if (select count(*) from public.erros_reportados where user_id = uid and criado_em > now() - interval '1 day') >= 30 then raise exception 'LIMITE'; end if;
    if exists (select 1 from public.erros_reportados where user_id = uid and origem = p_origem and ref_id = p_ref
                and ordem is not distinct from p_ordem::smallint and status = 'aberto') then
      update public.erros_reportados set motivo = p_motivo, comentario = left(coalesce(trim(p_comentario), ''), 500), criado_em = now()
       where user_id = uid and origem = p_origem and ref_id = p_ref and ordem is not distinct from p_ordem::smallint and status = 'aberto';
      return;
    end if;
  end if;
  insert into public.erros_reportados (user_id, origem, ref_id, ordem, motivo, comentario, trecho)
  values (uid, p_origem, p_ref, p_ordem, p_motivo, left(coalesce(trim(p_comentario), ''), 500), left(coalesce(trim(p_trecho), ''), 600));
end $$;

-- ============ administração ============
-- lista os avisos agrupados por item, com o conteúdo atual
create or replace function public.admin_erros(p_status text)
returns jsonb language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return (
    select coalesce(jsonb_agg(g order by g.ultimo desc), '[]'::jsonb) from (
      select e.origem, e.ref_id, e.ordem, max(e.criado_em) as ultimo, count(*) as total,
        jsonb_agg(jsonb_build_object('id', e.id, 'motivo', e.motivo, 'comentario', e.comentario, 'criado_em', e.criado_em,
                  'quem', coalesce(pf.nome, u.email, 'sem conta')) order by e.criado_em desc) as avisos,
        max(e.trecho) as trecho,
        case e.origem
          when 'questao' then (select jsonb_build_object('materia', q.materia, 'nivel', q.nivel, 'enunciado', q.enunciado, 'opcoes', q.opcoes,
                                 'explicacao', q.explicacao, 'ativa', q.ativa) from public.questoes q where q.id = e.ref_id)
          when 'cartao' then (select jsonb_build_object('materia', c.materia, 'assunto', c.assunto, 'tipo', c.tipo, 'frente', c.frente, 'verso', c.verso,
                                 'explicacao', c.explicacao, 'ativa', c.ativa, 'trilha', c.trilha) from public.cartoes c where c.id = e.ref_id)
          else (select jsonb_build_object('materia', sq.materia, 'texto_base', sq.texto_base, 'enunciado', sq.enunciado, 'opcoes', sq.opcoes,
                       'gabarito', sq.gabarito, 'explicacao', sq.explicacao, 'simulado', s.titulo, 'data', s.data, 'trilha', s.trilha)
                  from public.simulado_questoes sq join public.simulados s on s.id = sq.simulado_id
                 where sq.simulado_id = e.ref_id and sq.ordem = e.ordem)
        end as atual
      from public.erros_reportados e
      left join public.perfis pf on pf.id = e.user_id
      left join auth.users u on u.id = e.user_id
      where e.status = coalesce(p_status, 'aberto')
      group by e.origem, e.ref_id, e.ordem
      order by max(e.criado_em) desc
      limit 300
    ) g);
end $$;

create or replace function public.admin_erros_abertos()
returns integer language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return (select count(*) from (select 1 from public.erros_reportados where status = 'aberto' group by origem, ref_id, ordem) x);
end $$;

-- muda a situação de TODOS os avisos abertos de um item
create or replace function public.admin_erro_status(p_origem text, p_ref bigint, p_ordem integer, p_status text)
returns integer language plpgsql security definer set search_path = '' as $$
declare n integer;
begin
  perform public.admin_exigir();
  if p_status not in ('aberto', 'resolvido', 'descartado') then raise exception 'DADOS_INVALIDOS'; end if;
  update public.erros_reportados
     set status = p_status, resolvido_em = case when p_status = 'aberto' then null else now() end,
         resolvido_por = case when p_status = 'aberto' then null else auth.uid() end
   where origem = p_origem and ref_id = p_ref and ordem is not distinct from p_ordem::smallint
     and status <> p_status;
  get diagnostics n = row_count;
  return n;
end $$;

-- cartões de estudo: corrigir e ativar/desativar
create or replace function public.admin_cartao_salvar(p_id integer, p_frente text, p_verso text, p_explicacao text)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  if coalesce(trim(p_frente), '') = '' or coalesce(trim(p_verso), '') = '' then raise exception 'DADOS_INVALIDOS'; end if;
  update public.cartoes set frente = trim(p_frente), verso = trim(p_verso), explicacao = trim(coalesce(p_explicacao, '')), atualizado_em = now()
   where id = p_id;
  if not found then raise exception 'NAO_ENCONTRADO'; end if;
end $$;

create or replace function public.admin_cartao_ativar(p_id integer, p_ativa boolean)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  update public.cartoes set ativa = p_ativa, atualizado_em = now() where id = p_id;
  if not found then raise exception 'NAO_ENCONTRADO'; end if;
end $$;

-- questão de simulado: corrigir texto, alternativas, gabarito e explicação.
-- Se o gabarito mudar depois que alguém entregou, as notas são recalculadas.
create or replace function public.admin_simulado_questao_editar(p_simulado bigint, p_ordem integer, p_enunciado text, p_opcoes jsonb,
                                                                p_gabarito integer, p_explicacao text)
returns integer language plpgsql security definer set search_path = '' as $$
declare n integer := 0; old_gab smallint;
begin
  perform public.admin_exigir();
  if coalesce(trim(p_enunciado), '') = '' or jsonb_typeof(p_opcoes) <> 'array' or jsonb_array_length(p_opcoes) <> 5
     or p_gabarito is null or p_gabarito not between 0 and 4 then raise exception 'DADOS_INVALIDOS'; end if;
  select gabarito into old_gab from public.simulado_questoes where simulado_id = p_simulado and ordem = p_ordem;
  if not found then raise exception 'NAO_ENCONTRADO'; end if;
  update public.simulado_questoes set enunciado = trim(p_enunciado), opcoes = p_opcoes, gabarito = p_gabarito, explicacao = trim(coalesce(p_explicacao, ''))
   where simulado_id = p_simulado and ordem = p_ordem;
  if old_gab <> p_gabarito then
    update public.simulado_respostas r
       set acertos = (select count(*) from public.simulado_questoes q
                       where q.simulado_id = r.simulado_id and (r.respostas ->> q.ordem::text) ~ '^[0-4]$' and (r.respostas ->> q.ordem::text)::int = q.gabarito)
     where r.simulado_id = p_simulado and r.entregue_em is not null;
    get diagnostics n = row_count;
  end if;
  return n;
end $$;

-- ============ permissões ============
revoke all on function public.reportar_erro(text, bigint, integer, text, text, text), public.admin_erros(text), public.admin_erros_abertos(),
  public.admin_erro_status(text, bigint, integer, text), public.admin_cartao_salvar(integer, text, text, text), public.admin_cartao_ativar(integer, boolean),
  public.admin_simulado_questao_editar(bigint, integer, text, jsonb, integer, text) from public;
grant execute on function public.reportar_erro(text, bigint, integer, text, text, text) to anon, authenticated;
grant execute on function public.admin_erros(text), public.admin_erros_abertos(), public.admin_erro_status(text, bigint, integer, text),
  public.admin_cartao_salvar(integer, text, text, text), public.admin_cartao_ativar(integer, boolean),
  public.admin_simulado_questao_editar(bigint, integer, text, jsonb, integer, text) to authenticated;

select 'reportar erro pronto' as status;
