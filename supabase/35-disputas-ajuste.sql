-- Aprenda se Divertindo · 35 · Ajuste nas disputas
-- Rode depois do 33-disputas-placar.sql. Cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
-- Corrige o caso em que quem desafiou não terminou a própria parte (fechou o app, perdeu a conexão):
-- a disputa ficava presa, invisível para o desafiado, e bloqueava um novo desafio entre os dois.
-- Agora, ao lançar um novo desafio, essas disputas inacabadas são descartadas.

delete from public.disputas where d1_fim is null and recusada_em is null;

-- criar uma disputa (quem desafia joga em seguida, com as questões enviadas)
create or replace function public.criar_disputa(p_ranking uuid, p_desafiado uuid, p_trilha text, p_horas integer, p_questoes integer[])
returns uuid language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid(); v_id uuid;
begin
  if uid is null then raise exception 'LOGIN'; end if;
  if public.ranking_meu_papel(p_ranking) is null then raise exception 'SEM_ACESSO'; end if;
  if p_desafiado = uid then raise exception 'NAO_PODE_SI'; end if;
  if not exists (select 1 from public.ranking_membros where ranking_id = p_ranking and user_id = p_desafiado) then raise exception 'NAO_MEMBRO'; end if;
  if p_horas not in (5, 24) then raise exception 'PRAZO_INVALIDO'; end if;
  -- partida de desafio que a própria pessoa começou e não terminou (fechou o app, perdeu a conexão…): descarta
  delete from public.disputas d where d.desafiante = uid and d.d1_fim is null and d.recusada_em is null;
  if (select count(*) from public.disputas d where d.desafiante = uid
        and public.disputa_status(d) in ('preparando','aguardando','jogando')) >= 3 then
    raise exception 'LIMITE_DISPUTAS';
  end if;
  if exists (select 1 from public.disputas d
              where ((d.desafiante = uid and d.desafiado = p_desafiado) or (d.desafiante = p_desafiado and d.desafiado = uid))
                and (public.disputa_status(d) in ('aguardando','jogando')
                     or (public.disputa_status(d) = 'preparando' and d.criada_em > now() - interval '1 hour'))) then
    raise exception 'DISPUTA_ABERTA';
  end if;
  insert into public.disputas (ranking_id, desafiante, desafiado, trilha, horas, questoes, expira_em)
  values (p_ranking, uid, p_desafiado, p_trilha, p_horas, p_questoes, now() + make_interval(hours => p_horas))
  returning id into v_id;
  return v_id;
end $$;

select 'ajuste das disputas pronto' as status;
