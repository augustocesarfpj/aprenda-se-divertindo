-- Aprenda se Divertindo · 58 · Lançar e editar questões pela página de administração
-- Rode depois do 57-plano-pago-indicacoes.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- As questões lançadas pela administração recebem números a partir de 1.000.000, para nunca
-- se misturarem com os lotes que vêm no arquivo do jogo. Elas aparecem para os jogadores na hora.
-- Questões desativadas somem do jogo (inclusive as que vieram no arquivo).
-- Os arquivos de lote de questões (.sql) também podem ser carregados pela administração, sem passar pelo Supabase.

-- números das questões desativadas (o jogo usa para esconder as do arquivo)
create or replace function public.questoes_inativas()
returns setof integer language sql stable security definer set search_path = '' as $$
  select id from public.questoes where not ativa;
$$;

-- confere e limpa uma questão; devolve o motivo do problema ou null se estiver tudo certo
create or replace function public.questao_problema(p_materia text, p_nivel integer, p_enunciado text, p_opcoes jsonb)
returns text language plpgsql immutable set search_path = '' as $$
declare o text[];
begin
  if p_materia is null or p_materia !~ '^[a-z]{2,8}$' then return 'MATERIA'; end if;
  if p_nivel is null or p_nivel not between 0 and 4 then return 'NIVEL'; end if;
  if length(trim(coalesce(p_enunciado, ''))) < 8 then return 'ENUNCIADO'; end if;
  if jsonb_typeof(p_opcoes) <> 'array' or jsonb_array_length(p_opcoes) <> 4 then return 'OPCOES'; end if;
  select array_agg(lower(trim(x))) into o from jsonb_array_elements_text(p_opcoes) x;
  if exists (select 1 from unnest(o) v where v = '') then return 'OPCAO_VAZIA'; end if;
  if (select count(distinct v) from unnest(o) v) < 4 then return 'OPCAO_REPETIDA'; end if;
  return null;
end $$;

create or replace function public.questao_proximo_id()
returns integer language sql stable security definer set search_path = '' as $$
  select greatest(1000000, coalesce((select max(id) + 1 from public.questoes where id >= 1000000), 1000000));
$$;

-- salvar uma questão: sem p_id cria uma nova; com p_id corrige a existente
create or replace function public.admin_questao_salvar(p_id integer, p_materia text, p_nivel integer, p_enunciado text,
                                                       p_opcoes jsonb, p_explicacao text default '')
returns integer language plpgsql security definer set search_path = '' as $$
declare prob text; v_id integer; ops jsonb;
begin
  perform public.admin_exigir();
  prob := public.questao_problema(p_materia, p_nivel, p_enunciado, p_opcoes);
  if prob is not null then raise exception 'QUESTAO_%', prob; end if;
  select jsonb_agg(trim(x)) into ops from jsonb_array_elements_text(p_opcoes) x;
  if p_id is null then
    lock table public.questoes in share row exclusive mode;
    v_id := public.questao_proximo_id();
    insert into public.questoes (id, materia, nivel, enunciado, opcoes, explicacao, ativa)
    values (v_id, p_materia, p_nivel, trim(p_enunciado), ops, trim(coalesce(p_explicacao, '')), true);
  else
    update public.questoes set materia = p_materia, nivel = p_nivel, enunciado = trim(p_enunciado), opcoes = ops,
           explicacao = trim(coalesce(p_explicacao, ''))
     where id = p_id returning id into v_id;
    if v_id is null then raise exception 'NAO_ENCONTRADA'; end if;
  end if;
  return v_id;
end $$;

-- lançar várias de uma vez: [{materia, nivel, enunciado, opcoes:[certa, e1, e2, e3], explicacao}, ...]
create or replace function public.admin_questoes_importar(p_lista jsonb)
returns json language plpgsql security definer set search_path = '' as $$
declare q jsonb; prob text; v_id integer; primeiro integer; n integer := 0; i integer := 0;
begin
  perform public.admin_exigir();
  if jsonb_typeof(p_lista) <> 'array' or jsonb_array_length(p_lista) = 0 then raise exception 'LISTA_VAZIA'; end if;
  if jsonb_array_length(p_lista) > 500 then raise exception 'LISTA_GRANDE'; end if;
  lock table public.questoes in share row exclusive mode;
  for q in select * from jsonb_array_elements(p_lista) loop
    i := i + 1;
    prob := public.questao_problema(q->>'materia', (q->>'nivel')::integer, q->>'enunciado', q->'opcoes');
    if prob is not null then raise exception 'QUESTAO_% (linha %)', prob, i; end if;
  end loop;
  for q in select * from jsonb_array_elements(p_lista) loop
    v_id := public.questao_proximo_id();
    insert into public.questoes (id, materia, nivel, enunciado, opcoes, explicacao, ativa)
    values (v_id, q->>'materia', (q->>'nivel')::integer, trim(q->>'enunciado'),
            (select jsonb_agg(trim(x)) from jsonb_array_elements_text(q->'opcoes') x),
            trim(coalesce(q->>'explicacao', '')), true);
    if primeiro is null then primeiro := v_id; end if;
    n := n + 1;
  end loop;
  return json_build_object('inseridas', n, 'primeiro_id', primeiro, 'ultimo_id', v_id);
end $$;

create or replace function public.admin_questao_ativar(p_id integer, p_ativa boolean)
returns void language plpgsql security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  update public.questoes set ativa = p_ativa where id = p_id;
  if not found then raise exception 'NAO_ENCONTRADA'; end if;
end $$;

create or replace function public.admin_questoes_inativas()
returns json language plpgsql stable security definer set search_path = '' as $$
begin
  perform public.admin_exigir();
  return coalesce((select json_agg(json_build_object('id', q.id, 'materia', q.materia, 'nivel', q.nivel, 'enunciado', q.enunciado,
                                                     'opcoes', q.opcoes, 'explicacao', q.explicacao) order by q.id desc)
                   from public.questoes q where not q.ativa), '[]'::json);
end $$;


-- carregar um arquivo de lote (os .sql de questões): mantém os números das questões do arquivo
create or replace function public.admin_questoes_carregar(p_lista jsonb)
returns json language plpgsql security definer set search_path = '' as $$
declare q jsonb; prob text; i integer := 0; novas integer := 0; atual integer := 0; ins boolean;
begin
  perform public.admin_exigir();
  if jsonb_typeof(p_lista) <> 'array' or jsonb_array_length(p_lista) = 0 then raise exception 'LISTA_VAZIA'; end if;
  if jsonb_array_length(p_lista) > 1000 then raise exception 'LISTA_GRANDE'; end if;
  for q in select * from jsonb_array_elements(p_lista) loop
    i := i + 1;
    if (q->>'id') is null or (q->>'id') !~ '^[0-9]+$' or (q->>'id')::bigint >= 1000000 then raise exception 'QUESTAO_ID (linha %)', i; end if;
    prob := public.questao_problema(q->>'materia', (q->>'nivel')::integer, q->>'enunciado', q->'opcoes');
    if prob is not null then raise exception 'QUESTAO_% (linha %)', prob, i; end if;
  end loop;
  for q in select * from jsonb_array_elements(p_lista) loop
    insert into public.questoes (id, materia, nivel, enunciado, opcoes, explicacao)
    values ((q->>'id')::integer, q->>'materia', (q->>'nivel')::integer, q->>'enunciado', q->'opcoes', coalesce(q->>'explicacao', ''))
    on conflict (id) do update set materia = excluded.materia, nivel = excluded.nivel, enunciado = excluded.enunciado,
                                   opcoes = excluded.opcoes, explicacao = excluded.explicacao
    returning (xmax = 0) into ins;
    if ins then novas := novas + 1; else atual := atual + 1; end if;
  end loop;
  return json_build_object('novas', novas, 'atualizadas', atual);
end $$;

revoke all on function public.questao_problema(text, integer, text, jsonb), public.questao_proximo_id() from public, anon, authenticated;
revoke all on function public.questoes_inativas() from public;
grant execute on function public.questoes_inativas() to anon, authenticated;
revoke all on function public.admin_questao_salvar(integer, text, integer, text, jsonb, text), public.admin_questoes_importar(jsonb),
  public.admin_questao_ativar(integer, boolean), public.admin_questoes_inativas(), public.admin_questoes_carregar(jsonb) from public, anon;
grant execute on function public.admin_questao_salvar(integer, text, integer, text, jsonb, text), public.admin_questoes_importar(jsonb),
  public.admin_questao_ativar(integer, boolean), public.admin_questoes_inativas(), public.admin_questoes_carregar(jsonb) to authenticated;

select 'lançamento de questões pronto' as status, (select count(*) from public.questoes) as questoes_no_banco;
