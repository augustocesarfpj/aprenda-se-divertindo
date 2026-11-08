# Pix automático pelo PagBank

Com isto ligado, o jogador escolhe o plano, informa nome e CPF, o PagBank gera o Pix e o Premium (com a comissão da indicação) é liberado sozinho quando o pagamento cai. Ninguém da administração precisa confirmar.

## Passo a passo (uma vez só)

1. **PagBank**: tenha uma conta com **chave Pix cadastrada** no app do PagBank. Sem chave, o PagBank não gera o Pix.
2. **Token**: no site do PagBank (minha conta), procure a área de **Integrações** e gere o token da API. Não cole o token no chat nem no site.
3. **Supabase → Edge Functions → Secrets**: crie o segredo `PAGBANK_TOKEN` com o token. (Opcional: `PAGBANK_ENV` = `sandbox` para usar um token de testes.)
4. **Supabase → Edge Functions → Deploy a new function → Via editor**: nome `pagbank-pix`, cole todo o arquivo `index.ts` desta pasta e clique em Deploy.
5. Nas configurações da função `pagbank-pix`, **desligue a verificação de JWT** ("Verify JWT" / "Enforce JWT verification"). O PagBank avisa o pagamento sem login; a função sempre confere com o PagBank antes de liberar.
6. **SQL Editor**: rode `supabase/106-pagbank-pix-automatico.sql`.
7. **admin.html → Configurações → Pix automático (PagBank)**: marque e salve.

## Teste com dinheiro de verdade (R$ 1,00)

1. Em admin.html, mude o preço do plano Mensal para 1,00 e salve.
2. No jogo, com a sua conta, escolha Mensal, gere o Pix e pague.
3. Em segundos a janela mostra "Pagamento confirmado" e o pagamento aparece em Pagamentos como "PagBank automático".
4. Volte o preço do Mensal para 12,90.

Se algo falhar, a mensagem de erro do PagBank aparece entre parênteses na janela do Premium, e o registro completo fica em Supabase → Edge Functions → pagbank-pix → Logs.

Para desligar a qualquer momento: desmarque em admin.html. O Pix manual volta na hora.
