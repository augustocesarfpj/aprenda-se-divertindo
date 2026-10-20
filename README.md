# Aprenda se Divertindo

Jogo de perguntas de concursos públicos em 30 níveis, até R$ 1 milhão (fictício).

- 7.339 questões em 35 matérias e 5 níveis (fácil, intermediária, difícil, muito difícil e desafio)
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

Para configurar, rode no SQL Editor, nesta ordem, os arquivos da pasta `supabase/`: `1-estrutura.sql`, `2-questoes-parte1.sql`, `3-questoes-parte2.sql`, `4-questoes-parte3.sql`, `5-questoes-faceis.sql`, `6-excluir-conta.sql`, `7-contador.sql`, `8-questoes-faceis-2.sql`, `9-questoes-intermediarias.sql`, `10-questoes-faceis-3.sql`, `11-estudo.sql`, `12-cartoes-estudo.sql`, `13-topicos-que-mais-caem.sql`, `14-edital-pcba.sql`, `15-edital-pcba-2.sql`, `16-edital-trf4.sql`, `17-edital-trf4-2.sql`, `18-edital-receita.sql`, `19-edital-receita-2.sql`, `20-trilha-enem.sql`, `21-trilha-enem-2.sql`, `22-trilha-enem-3.sql`, `23-trilha-enem-4.sql`, `24-trilha-enem-5.sql`, `25-ranking.sql`, `26-trilha-enem-6.sql`, `27-trilha-enem-7.sql`, `28-trilha-enem-8.sql`, `29-trilha-enem-9.sql`, `30-trilha-enem-10.sql`, `31-ranking-cargos-semana.sql`, `32-disputas.sql`, `33-disputas-placar.sql`, `34-trilha-enem-11.sql`, `35-disputas-ajuste.sql`, `36-ranking-bonus-distancia.sql`, `38-trilha-saude.sql`, `39-trilha-saude-2.sql`, `40-trilha-saude-3.sql`, `41-trilha-saude-4.sql`, `42-trilha-saude-5.sql`, `43-trilha-saude-6.sql`, `44-trilha-saude-7.sql`, `45-trilha-policial.sql`, `46-trilha-policial-2.sql`, `47-trilha-policial-3.sql`, `48-sabado-do-saque.sql`, `49-admin.sql`, `50-trilha-policial-4.sql`, `51-trilha-policial-5.sql`, `52-trilha-policial-6.sql`, `53-trilha-policial-7.sql`, `54-trilha-policial-8.sql`, `55-trilha-enem-12.sql`, `56-trilha-enem-13.sql`, `57-plano-pago-indicacoes.sql`, `58-admin-questoes.sql`, `59-trilha-policial-9.sql`, `60-trilha-policial-10.sql`, `61-trilha-policial-11.sql`, `62-trilha-policial-12.sql`, `63-trilha-saude-8.sql`, `64-trilha-enem-14.sql`, `65-trilha-enem-15.sql`, `66-trilha-fiscal-extra.sql`, `67-trilha-fiscal-extra-2.sql`, `68-trilha-tribunais-extra.sql`, `69-versao-questoes.sql`, `70-trava-resultados.sql`, `71-admin-trocar-senha.sql`, `72-meta-estudo-50.sql`, `73-simulado-domingo.sql`, `74-cartoes-policial.sql`, `75-reportar-erro.sql`, `76-cartoes-policial-2.sql`, `77-cartoes-enem.sql`, `78-cartoes-tribunais.sql`, `79-cartoes-fiscal.sql`, `80-cartoes-saude.sql`, `81-trilha-policial-13.sql`, `82-trilha-policial-14.sql`, `83-trilha-enem-16.sql`, `84-trilha-tribunais-extra-2.sql`, `85-trilha-saude-9.sql`, `86-trilha-fiscal-extra-3.sql`, `87-ranking-mensal.sql`, `88-simulado-policial-1.sql`, `89-simulado-enem-1.sql`, `90-simulado-saude-1.sql`, `91-cartoes-policial-3.sql`, `92-cartoes-enem-2.sql` e `93-cartoes-fiscal-2.sql`. O resumo diário de visitantes e partidas fica na visão `resumo_diario`. Para ver quantas questões há em cada trilha e matéria, rode `relatorio-questoes-por-trilha.sql` (só consulta, não altera nada; sai tudo numa tabela só).

A política de privacidade fica em `privacidade.html`.

## Administração

A página `admin.html` mostra visitantes, contas, partidas, retenção por semana, jogadores, questões por trilha e rankings. Só abre para quem está na tabela `admins` (o `49-admin.sql` já cadastra o criador do jogo). Para dar acesso a outra pessoa, use a aba Configurações → Administradores (a pessoa precisa ter conta no jogo).

## Plano pago e indicação

Com o `57-plano-pago-indicacoes.sql`, quem tem conta grátis joga 5 provas e estuda 5 cartões por dia; o Premium libera tudo. Planos mensal, trimestral, semestral e anual, pagos por Pix: o jogador escolhe o plano, paga pelo Pix copia e cola e manda o comprovante por e-mail; o pedido aparece em **Pagamentos** na administração, e ao confirmar o Premium é liberado na hora. Quem já tinha conta quando o arquivo rodou pela primeira vez ganhou 3 meses (plano trimestral).

Indicação (promoção por tempo limitado): cada jogador tem um link `?ref=CÓDIGO`. Cada pagamento confirmado de um indicado rende a comissão configurada (R$ 2,90) para quem indicou, enquanto ele mantiver a assinatura. As comissões fecham no dia 30 e são liberadas no dia 5 do mês seguinte; o saque pode ser pedido a partir de R$ 50,00 e é pago no dia 5.

Na aba **Questões** da administração dá para lançar uma questão por vez ou colar várias de uma planilha (Matéria · Nível · Enunciado · Certa · Errada 1 · Errada 2 · Errada 3 · Explicação), com aviso de questões parecidas já existentes, além de buscar, editar e desativar qualquer questão. As lançadas por lá recebem números a partir de 1.000.000 e entram no jogo na hora. Os arquivos `.sql` de lotes de questões também podem ser carregados por essa aba (botão “Carregar arquivo de lote”), sem abrir o Supabase; os arquivos que mudam outras partes do jogo continuam sendo rodados no SQL Editor.

Tudo se administra pelas abas **Pagamentos**, **Assinantes** (habilitar ou remover Premium pelo e-mail), **Indicações** (saques e comissões) e **Configurações** (e-mails de notificação, chave Pix, preços, limites, promoção e administradores).
