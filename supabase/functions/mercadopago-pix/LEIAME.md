# Pix automático pelo Mercado Pago

Com isto ligado, o jogador escolhe o plano, informa nome e CPF, o Mercado Pago gera o Pix e o Premium (com a comissão da indicação) é liberado sozinho quando o pagamento é aprovado. Ninguém da administração precisa confirmar.

## Passo a passo (uma vez só)

1. **Mercado Pago**: tenha uma conta com **chave Pix cadastrada** no app do Mercado Pago. Sem chave, o Pix não é gerado.
2. **Token**: entre em mercadopago.com.br/developers → **Suas integrações** → **Criar aplicação** (tipo "Pagamentos on-line", sem plataforma pronta). Dentro da aplicação, abra **Credenciais de produção** e copie o **Access Token** (começa com `APP_USR-`). Não cole o token no chat nem no site.
3. **Supabase → Edge Functions → Secrets**: crie o segredo `MP_ACCESS_TOKEN` com o token.
4. **Supabase → Edge Functions → Deploy a new function → Via editor**: nome `mercadopago-pix`, cole todo o arquivo `index.ts` desta pasta e clique em Deploy.
5. Nas configurações da função `mercadopago-pix`, **desligue a verificação de JWT** ("Verify JWT"). O Mercado Pago avisa o pagamento sem login; a função sempre confere com o Mercado Pago antes de liberar.
6. **SQL Editor**: rode `supabase/117-mercadopago-pix-automatico.sql`.
7. **admin.html → Configurações → Pix automático (Mercado Pago)**: marque e salve.

Não precisa cadastrar webhook no painel do Mercado Pago: cada Pix já leva o endereço do aviso.

## Teste com dinheiro de verdade (R$ 1,00)

1. Em admin.html, mude o preço do plano Mensal para 1,00 e salve.
2. No jogo, entre com uma conta cujo e-mail **não** seja o da sua conta do Mercado Pago (ele recusa cobrar de si mesmo), escolha Mensal, gere o Pix e pague pelo app de outro banco.
3. Em segundos a janela mostra "Pagamento confirmado" e o pagamento aparece em Pagamentos como "Mercado Pago automático".
4. Volte o preço do Mensal para 12,90.

Se algo falhar, a mensagem do Mercado Pago aparece entre parênteses na janela do Premium, e o registro completo fica em Supabase → Edge Functions → mercadopago-pix → Logs.

Para desligar a qualquer momento: desmarque em admin.html. Se o PagBank estiver ligado, ele volta a ser usado; senão, volta o Pix manual.
