-- Aprenda se Divertindo · 111 · Repete os simulados de Enem, Fiscal, Tribunais e Administrativa em 14–15/11
-- Rode depois do 110-simulado-saude-2.sql. Cole tudo no SQL Editor e clique em Run.
-- Para cada trilha, pega o último simulado antes de 15/11:
--   • se ninguém fez, ele só muda de data e abre de novo no sábado, 14/11, às 0h, até domingo, 15/11, às 23h59;
--   • se alguém já fez, cria uma cópia para 15/11 e tira o antigo do ar (para o gabarito liberado não vazar).
-- As mensagens (NOTICE) mostram o que aconteceu em cada trilha. Pode rodar de novo sem problema.

do $$
declare t text; v record; nid bigint;
begin
  foreach t in array array['enem','fiscal','tribunais','administrativa'] loop
    if exists (select 1 from public.simulados where trilha = t and data = date '2026-11-15') then
      raise notice '%: já existe simulado em 15/11, nada a fazer.', t;
      continue;
    end if;
    select * into v from public.simulados where trilha = t and data < date '2026-11-15' order by data desc limit 1;
    if v.id is null then raise notice '%: nenhum simulado anterior encontrado.', t; continue; end if;
    if not exists (select 1 from public.simulado_respostas r where r.simulado_id = v.id) then
      update public.simulados set data = date '2026-11-15', publicado = true where id = v.id;
      raise notice '%: simulado % movido para 15/11.', t, v.id;
    else
      insert into public.simulados (trilha, data, titulo, estilo, duracao_min, publicado)
      values (t, date '2026-11-15', v.titulo, v.estilo, v.duracao_min, true) returning id into nid;
      insert into public.simulado_questoes (simulado_id, ordem, materia, texto_base, enunciado, opcoes, gabarito, explicacao)
      select nid, ordem, materia, texto_base, enunciado, opcoes, gabarito, explicacao
        from public.simulado_questoes where simulado_id = v.id;
      update public.simulados set publicado = false where id = v.id;
      raise notice '%: simulado copiado para 15/11 (novo id %); o anterior saiu do ar.', t, nid;
    end if;
  end loop;
end $$;

select s.trilha, s.data - 1 as abre_sabado, s.data as fecha_domingo, s.titulo, s.publicado, count(q.ordem) as questoes
  from public.simulados s left join public.simulado_questoes q on q.simulado_id = s.id
 where s.data = date '2026-11-15' group by s.id order by s.trilha;
