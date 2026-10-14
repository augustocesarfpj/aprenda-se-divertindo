# Aprenda se Divertindo

Jogo de perguntas de concursos públicos em 30 níveis, até R$ 1 milhão (fictício).

- 4.239 questões em 35 matérias e 5 níveis (fácil, intermediária, difícil, muito difícil e desafio)
- Trilhas: PC-BA (Investigador, edital 2026), Policial, Tribunais, Fiscal, Administrativa e Geral
- Desafio do dia, sequência de dias e compartilhamento do resultado
- Ajudas: pular, eliminar duas, turma, professor e resposta de risco
- Módulo de estudo (só com conta): cartões “Sei / Não sei” e “Acertei / Errei”, com repetição espaçada, meta diária e alerta de falsa certeza

Tudo fica em um único `index.html`, sem servidor. O progresso é salvo no navegador de cada jogador.

## Banco de dados (Supabase)

O jogo funciona sozinho, mas quando o Supabase está configurado ele passa a:

- carregar as questões da tabela `questoes`. Questões novas entram no banco sem mexer no site, e as do arquivo servem de reserva.
- permitir criar conta com e-mail e senha;
- salvar o progresso (estatísticas, sequência de dias, questões vistas) e as partidas (base do ranking).

Para configurar, rode no SQL Editor, nesta ordem, os arquivos da pasta `supabase/`: `1-estrutura.sql`, `2-questoes-parte1.sql`, `3-questoes-parte2.sql`, `4-questoes-parte3.sql`, `5-questoes-faceis.sql`, `6-excluir-conta.sql`, `7-contador.sql`, `8-questoes-faceis-2.sql`, `9-questoes-intermediarias.sql`, `10-questoes-faceis-3.sql`, `11-estudo.sql`, `12-cartoes-estudo.sql`, `13-topicos-que-mais-caem.sql`, `14-edital-pcba.sql`, `15-edital-pcba-2.sql`, `16-edital-trf4.sql`, `17-edital-trf4-2.sql`, `18-edital-receita.sql`, `19-edital-receita-2.sql`, `20-trilha-enem.sql`, `21-trilha-enem-2.sql`, `22-trilha-enem-3.sql`, `23-trilha-enem-4.sql`, `24-trilha-enem-5.sql`, `25-ranking.sql`, `26-trilha-enem-6.sql` e `27-trilha-enem-7.sql`. O resumo diário de visitantes e partidas fica na visão `resumo_diario`.

A política de privacidade fica em `privacidade.html`.
