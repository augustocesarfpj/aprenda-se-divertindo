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

Para configurar, rode no SQL Editor, nesta ordem, os arquivos da pasta `supabase/`: `1-estrutura.sql`, `2-questoes-parte1.sql`, `3-questoes-parte2.sql`, `4-questoes-parte3.sql`, `5-questoes-faceis.sql`, `6-excluir-conta.sql`, `7-contador.sql`, `8-questoes-faceis-2.sql`, `9-questoes-intermediarias.sql`, `10-questoes-faceis-3.sql`, `11-estudo.sql`, `12-cartoes-estudo.sql`, `13-topicos-que-mais-caem.sql`, `14-edital-pcba.sql`, `15-edital-pcba-2.sql`, `16-edital-trf4.sql`, `17-edital-trf4-2.sql`, `18-edital-receita.sql`, `19-edital-receita-2.sql`, `20-trilha-enem.sql`, `21-trilha-enem-2.sql`, `22-trilha-enem-3.sql`, `23-trilha-enem-4.sql`, `24-trilha-enem-5.sql`, `25-ranking.sql`, `26-trilha-enem-6.sql`, `27-trilha-enem-7.sql`, `28-trilha-enem-8.sql`, `29-trilha-enem-9.sql`, `30-trilha-enem-10.sql`, `31-ranking-cargos-semana.sql`, `32-disputas.sql`, `33-disputas-placar.sql`, `34-trilha-enem-11.sql`, `35-disputas-ajuste.sql`, `36-ranking-bonus-distancia.sql`, `38-trilha-saude.sql`, `39-trilha-saude-2.sql`, `40-trilha-saude-3.sql`, `41-trilha-saude-4.sql`, `42-trilha-saude-5.sql`, `43-trilha-saude-6.sql`, `44-trilha-saude-7.sql`, `45-trilha-policial.sql`, `46-trilha-policial-2.sql`, `47-trilha-policial-3.sql`, `48-sabado-do-saque.sql`, `49-admin.sql`, `50-trilha-policial-4.sql`, `51-trilha-policial-5.sql`, `52-trilha-policial-6.sql`, `53-trilha-policial-7.sql`, `54-trilha-policial-8.sql`, `55-trilha-enem-12.sql`, `56-trilha-enem-13.sql`, `57-plano-pago-indicacoes.sql`, `58-admin-questoes.sql`, `59-trilha-policial-9.sql`, `60-trilha-policial-10.sql`, `61-trilha-policial-11.sql`, `62-trilha-policial-12.sql`, `63-trilha-saude-8.sql`, `64-trilha-enem-14.sql`, `65-trilha-enem-15.sql`, `66-trilha-fiscal-extra.sql`, `67-trilha-fiscal-extra-2.sql`, `68-trilha-tribunais-extra.sql`, `69-versao-questoes.sql`, `70-trava-resultados.sql`, `71-admin-trocar-senha.sql`, `72-meta-estudo-50.sql`, `73-simulado-domingo.sql`, `74-cartoes-policial.sql`, `75-reportar-erro.sql`, `76-cartoes-policial-2.sql`, `77-cartoes-enem.sql`, `78-cartoes-tribunais.sql`, `79-cartoes-fiscal.sql`, `80-cartoes-saude.sql`, `81-trilha-policial-13.sql`, `82-trilha-policial-14.sql`, `83-trilha-enem-16.sql`, `84-trilha-tribunais-extra-2.sql`, `85-trilha-saude-9.sql`, `86-trilha-fiscal-extra-3.sql`, `87-ranking-mensal.sql`, `91-cartoes-policial-3.sql`, `92-cartoes-enem-2.sql`, `93-cartoes-fiscal-2.sql`, `94-cartoes-saude-2.sql`, `95-cartoes-tribunais-2.sql`, `96-cartoes-administrativa.sql`, `97-simulado-fim-de-semana.sql`, `99-simulado-prorrogacao.sql`, `101-trilha-policial-15.sql`, `105-trilha-policial-16.sql`, `106-pagbank-pix-automatico.sql`, `107-admin-ranking-simulado.sql`, `108-ranking-simulado-amigos.sql`, `111-repete-simulados-15-nov.sql`, `112-campeonatos.sql`, `113-campeonatos-formatos.sql`, `114-trilha-policial-17.sql`, `115-trilha-policial-18.sql`, `117-mercadopago-pix-automatico.sql`, `118-trilha-policial-troca-faceis.sql`, `119-trilha-policial-19.sql`, `120-trilha-policial-20.sql`, `121-trilha-policial-21-faceis.sql`, `122-materias-gerais.sql`, `123-gerais-const-adm-rl-inf-port.sql`, `124-enem.sql`, `126-revisao-leis-2026.sql`, `127-leis-novas-2026.sql`, `128-seguranca-revisao.sql`, `129-limites-no-servidor.sql`, `130-captcha-e-contador.sql`, `131-fechar-funcoes-visitante.sql`, `132-ranking-simulado-situacao.sql`, `134-emails-automaticos.sql`, `135-email-notificacao-jogo.sql`, `136-equilibrio-sust-ia.sql`, `137-equilibrio-igual-pcd.sql` e `138-equilibrio-sust-ia-2.sql` (o 133 é simulado e fica no repositório privado). Os simulados com gabarito (antigos 88, 89, 90, 98, 100, 102, 103, 104, 109, 110, 116 e 125 e todos os próximos) ficam só no repositório privado `aprenda-backup`, em `simulados/`, e são aplicados no banco automaticamente; assim o gabarito não aparece no site. O resumo diário de visitantes e partidas fica na visão `resumo_diario`. Para ver quantas questões há em cada trilha e matéria, rode `relatorio-questoes-por-trilha.sql` (só consulta, não altera nada; sai tudo numa tabela só).

A política de privacidade fica em `privacidade.html`.

## Administração

A página `admin.html` mostra visitantes, contas, partidas, retenção por semana, jogadores, questões por trilha e rankings. Só abre para quem está na tabela `admins` (o `49-admin.sql` já cadastra o criador do jogo). Para dar acesso a outra pessoa, use a aba Configurações → Administradores (a pessoa precisa ter conta no jogo).

## Plano pago e indicação

Com o `57-plano-pago-indicacoes.sql`, quem tem conta grátis joga 5 provas e estuda 5 cartões por dia; o Premium libera tudo. Planos mensal, trimestral, semestral e anual, pagos por Pix: o jogador escolhe o plano, paga pelo Pix copia e cola e manda o comprovante por e-mail; o pedido aparece em **Pagamentos** na administração, e ao confirmar o Premium é liberado na hora. Quem já tinha conta quando o arquivo rodou pela primeira vez ganhou 3 meses (plano trimestral).

Indicação (promoção por tempo limitado): cada jogador tem um link `?ref=CÓDIGO`. Cada pagamento confirmado de um indicado rende a comissão configurada (R$ 2,90) para quem indicou, enquanto ele mantiver a assinatura. As comissões fecham no dia 30 e são liberadas no dia 5 do mês seguinte; o saque pode ser pedido a partir de R$ 50,00 e é pago no dia 5.

Na aba **Questões** da administração dá para lançar uma questão por vez ou colar várias de uma planilha (Matéria · Nível · Enunciado · Certa · Errada 1 · Errada 2 · Errada 3 · Explicação), com aviso de questões parecidas já existentes, além de buscar, editar e desativar qualquer questão. As lançadas por lá recebem números a partir de 1.000.000 e entram no jogo na hora. Os arquivos `.sql` de lotes de questões também podem ser carregados por essa aba (botão “Carregar arquivo de lote”), sem abrir o Supabase; os arquivos que mudam outras partes do jogo continuam sendo rodados no SQL Editor.

Tudo se administra pelas abas **Pagamentos**, **Assinantes** (habilitar ou remover Premium pelo e-mail), **Indicações** (saques e comissões) e **Configurações** (e-mails de notificação, chave Pix, preços, limites, promoção e administradores).

## Segurança

- A biblioteca do Supabase fica no próprio site, em `vendor/supabase.js` (sem CDN de terceiros). Para trocar de versão, mude `VERSAO` em `.github/workflows/biblioteca.yml`.
- `index.html` e `admin.html` têm política de segurança de conteúdo (CSP): só carregam scripts do próprio site e só conversam com o Supabase do jogo. Se um dia o site precisar de outro serviço, ele tem de entrar nessa lista.
- Os limites do plano grátis também são conferidos pelo banco (`129-limites-no-servidor.sql`).
- CAPTCHA (Cloudflare Turnstile, grátis) no Entrar e no Criar conta, do jogo e do admin (`captcha.js`). A chave do site fica em Administração → Configurações; a chave secreta só no Supabase (Authentication → Attack Protection).
- No cadastro e na troca de senha, o site recusa senhas que já apareceram em vazamentos (Have I Been Pwned, grátis; só os 5 primeiros caracteres do resumo da senha saem do aparelho).
- O contador de visitas e de partidas sem conta tem teto diário, para um robô não encher o banco (`130-captcha-e-contador.sql`).

## E-mails automáticos

O banco anota os e-mails numa fila (`134-emails-automaticos.sql`) e o workflow **E-mails automáticos** do repositório privado `aprenda-backup` envia pelo Gmail a cada 30 minutos (6h às 23h30). Tudo grátis.

- **Para o jogador:** Premium ativado, Premium vence em 3 dias e Premium venceu.
- **Para o admin** (e-mails de notificação das Configurações): um resumo com pagamento confirmado, Pix aguardando confirmação manual, pedido de saque, erro reportado e cadastro novo.
- **Esqueci minha senha:** com a opção ligada no admin, o jogo manda o link de senha nova direto para o jogador (pelo próprio Supabase).

Configuração (uma vez só; as senhas nunca vão para o chat nem para o código):

1. **Gmail do jogo:** de preferência uma conta só para o jogo. Ative a verificação em duas etapas e crie uma **senha de app** em myaccount.google.com/apppasswords (16 letras).
2. **GitHub → aprenda-backup → Settings → Secrets and variables → Actions:** crie `EMAIL_REMETENTE` (o endereço do Gmail) e `EMAIL_SENHA_APP` (a senha de app).
3. **Supabase → Authentication → Emails → SMTP Settings:** ligue o SMTP próprio com host `smtp.gmail.com`, porta `465`, usuário = o Gmail, senha = a mesma senha de app, remetente “Aprenda se Divertindo”.
4. **Supabase → Authentication → Emails → Templates → Reset password:** assunto “Crie sua senha nova · Aprenda se Divertindo” e o texto do arquivo `supabase/emails/recuperar-senha.html`.
5. **Supabase → Authentication → URL Configuration:** Site URL `https://aprendasedivertindo.com.br` e, em Redirect URLs, `https://aprendasedivertindo.com.br/**`.
6. **Admin → Configurações → E-mails automáticos:** marque “Esqueci minha senha manda o link direto”. A linha “Fila” mostra se os envios estão saindo.

