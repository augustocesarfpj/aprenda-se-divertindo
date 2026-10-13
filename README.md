# Aprenda se Divertindo

Jogo de perguntas de concursos públicos em 30 níveis, até R$ 1 milhão (fictício).

- 2.415 questões em 17 matérias e 5 níveis (fácil, intermediária, difícil, muito difícil e desafio)
- Trilhas: Policial, Tribunais, Fiscal, Administrativa e Geral
- Desafio do dia, sequência de dias e compartilhamento do resultado
- Ajudas: pular, eliminar duas, turma, professor e resposta de risco

Tudo fica em um único `index.html`, sem servidor. O progresso é salvo no navegador de cada jogador.

## Banco de dados (Supabase)

O jogo funciona sozinho, mas quando o Supabase está configurado ele passa a:

- carregar as questões da tabela `questoes`. Questões novas entram no banco sem mexer no site, e as do arquivo servem de reserva.
- permitir criar conta com e-mail e senha;
- salvar o progresso (estatísticas, sequência de dias, questões vistas) e as partidas (base do ranking).

Para configurar, rode no SQL Editor, nesta ordem, os arquivos da pasta `supabase/`: `1-estrutura.sql`, `2-questoes-parte1.sql`, `3-questoes-parte2.sql`, `4-questoes-parte3.sql` e `5-questoes-faceis.sql`.
