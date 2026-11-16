// Aprenda se Divertindo · Edge Function "mercadopago-pix"
// Gera o Pix do Premium pelo Mercado Pago (API de Orders) e libera o Premium sozinho quando o pagamento é aprovado.
//
// Segredo (Supabase → Edge Functions → Secrets). NUNCA coloque o token no site nem no chat:
//   MP_ACCESS_TOKEN  Access Token de PRODUÇÃO do Mercado Pago (começa com APP_USR-)
// SUPABASE_URL e SUPABASE_SERVICE_ROLE_KEY já existem automaticamente nas Edge Functions.
//
// Publique com "Verify JWT" DESLIGADO: o Mercado Pago chama o aviso (webhook) sem login.
// No painel do Mercado Pago (Sua aplicação → Webhooks), cadastre a URL desta função com ?wh=1 e marque o evento "Order".
// Mesmo assim, ninguém consegue liberar Premium de mentira: a função sempre pergunta ao Mercado Pago,
// com o seu token, se o pagamento foi aprovado e confere o valor antes de liberar.
//
// Chamadas:
//   POST {acao:"criar", plano, cpf, nome}  (com o login do jogador)  → gera o Pix
//   POST {acao:"verificar"}                (com o login do jogador)  → pergunta ao Mercado Pago se já pagou
//   POST ?wh=1                             (o Mercado Pago chama)    → aviso de pedido (evento "order")

import { createClient } from "https://esm.sh/@supabase/supabase-js@2.49.4";

const TOKEN = Deno.env.get("MP_ACCESS_TOKEN") ?? "";
const API = "https://api.mercadopago.com";
const SB_URL = Deno.env.get("SUPABASE_URL")!;
const db = createClient(SB_URL, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!, { auth: { persistSession: false } });

const CORS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
const json = (b: unknown, s = 200) =>
  new Response(JSON.stringify(b), { status: s, headers: { ...CORS, "Content-Type": "application/json" } });

function cpfOk(c: string) {
  if (!/^\d{11}$/.test(c) || /^(\d)\1{10}$/.test(c)) return false;
  for (const n of [9, 10]) {
    let s = 0;
    for (let i = 0; i < n; i++) s += +c[i] * (n + 1 - i);
    if (((s * 10) % 11) % 10 !== +c[n]) return false;
  }
  return true;
}

async function mp(path: string, init: RequestInit = {}) {
  const r = await fetch(API + path, {
    ...init,
    headers: { Authorization: "Bearer " + TOKEN, "Content-Type": "application/json", ...(init.headers ?? {}) },
  });
  const t = await r.text();
  let b: any = null;
  try { b = JSON.parse(t); } catch { b = { raw: t.slice(0, 500) }; }
  return { ok: r.ok, status: r.status, body: b };
}

// soma, em centavos, o que já foi creditado nos pagamentos do pedido
function pagoCentavos(order: any) {
  const pays = order?.transactions?.payments ?? [];
  const ok = pays.filter((p: any) => p?.status === "processed" || p?.status_detail === "accredited");
  let total = ok.reduce((s: number, p: any) => s + (Number(p?.paid_amount ?? p?.amount) || 0), 0);
  if (!total && order?.status === "processed") total = Number(order?.total_paid_amount ?? order?.total_amount) || 0;
  return Math.round(total * 100);
}

async function conferir(orderId: string) {
  if (!/^[A-Za-z0-9]{5,64}$/.test(orderId)) return { ok: false, motivo: "ID" };
  const r = await mp("/v1/orders/" + orderId);
  if (!r.ok) return { ok: false, motivo: "MP_" + r.status };
  const pago = pagoCentavos(r.body);
  if (pago <= 0) return { ok: false, motivo: "NAO_PAGO", status: r.body?.status, detalhe: r.body?.status_detail };
  const { data, error } = await db.rpc("mp_confirmar", { p_pagamento: orderId, p_centavos: pago });
  if (error) return { ok: false, motivo: "BANCO", detalhe: error.message };
  return data;
}

async function usuario(req: Request) {
  const jwt = (req.headers.get("Authorization") ?? "").replace(/^Bearer\s+/i, "");
  if (!jwt) return null;
  const { data } = await db.auth.getUser(jwt);
  return data?.user ?? null;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: CORS });
  if (req.method !== "POST") return json({ erro: "METODO" }, 405);
  if (!TOKEN) return json({ erro: "SEM_TOKEN" }, 500);
  const url = new URL(req.url);
  let body: any = {};
  try { body = await req.json(); } catch { /* corpo vazio */ }

  // ---- aviso do Mercado Pago (webhook ou IPN) ----
  if (url.searchParams.get("wh") === "1") {
    const tipo = String(body?.type ?? url.searchParams.get("type") ?? url.searchParams.get("topic") ?? "");
    const id = String(body?.data?.id ?? url.searchParams.get("data.id") ?? url.searchParams.get("id") ?? "");
    if (tipo === "order" && id) {
      const r = await conferir(id);
      console.log("webhook", id, JSON.stringify(r));
    }
    return json({ recebido: true }); // sempre 200 para o Mercado Pago não ficar repetindo
  }

  const user = await usuario(req);
  if (!user) return json({ erro: "LOGIN" }, 401);

  // ---- o site pergunta se já pagou ----
  if (body.acao === "verificar") {
    const { data: p } = await db.rpc("mp_pedido_do", { p_user: user.id });
    if (!p?.pagamento) return json({ status: "sem_pedido" });
    if (p.status === "confirmado") return json({ status: "confirmado" });
    if (p.status !== "pendente") return json({ status: p.status });
    const r: any = await conferir(p.pagamento);
    return json({ status: r?.ok ? "confirmado" : "pendente" });
  }

  // ---- gerar o Pix ----
  if (body.acao === "criar") {
    const cpf = String(body.cpf ?? "").replace(/\D/g, "");
    if (!cpfOk(cpf)) return json({ erro: "CPF" }, 400);
    const { data: ped, error } = await db.rpc("mp_novo_pedido", { p_user: user.id, p_plano: String(body.plano ?? "") });
    if (error) return json({ erro: (error.message.match(/[A-Z_]{5,}/) ?? ["BANCO"])[0] }, 400);
    const nome = String(body.nome ?? "").replace(/[^\p{L} .'-]/gu, "").replace(/\s+/g, " ").trim().slice(0, 120)
      || ped.nome || String(ped.email ?? user.email ?? "Jogador").split("@")[0];
    const [primeiro, ...resto] = nome.split(" ");
    const expira = new Date(Date.now() + 30 * 60e3);
    const valor = (ped.centavos / 100).toFixed(2);
    const r = await mp("/v1/orders", {
      method: "POST",
      headers: { "X-Idempotency-Key": ped.id },
      body: JSON.stringify({
        type: "online",
        processing_mode: "automatic",
        total_amount: valor,
        external_reference: ped.id,
        description: "Premium " + ped.plano + " - Aprenda se Divertindo",
        payer: {
          email: ped.email ?? user.email,
          first_name: primeiro,
          last_name: resto.join(" ") || primeiro,
          identification: { type: "CPF", number: cpf },
        },
        transactions: { payments: [{ amount: valor, payment_method: { id: "pix", type: "bank_transfer" }, expiration_time: "PT30M" }] },
      }),
    });
    const pay = r.body?.transactions?.payments?.[0];
    const pm = pay?.payment_method;
    if (!r.ok || !pm?.qr_code) {
      await db.from("pagamentos").update({ status: "cancelado", decidido_em: new Date().toISOString(), obs: "Mercado Pago não gerou o Pix" }).eq("id", ped.id);
      const causas = (r.body?.errors ?? r.body?.cause ?? []).map((c: any) => [c.code, c.message ?? c.description].filter(Boolean).join(" ")).join("; ");
      console.log("criar falhou", r.status, JSON.stringify(r.body));
      return json({ erro: "MERCADOPAGO", detalhe: causas || r.body?.message || "HTTP " + r.status }, 502);
    }
    const png = pm.qr_code_base64 ? "data:image/png;base64," + pm.qr_code_base64 : null;
    const fim = pay?.date_of_expiration ?? r.body?.date_of_expiration;
    const exp = fim ? new Date(fim) : expira;
    await db.rpc("mp_registrar", { p_id: ped.id, p_pagamento: String(r.body.id), p_copia: pm.qr_code, p_qr: png, p_expira: exp.toISOString() });
    return json({ id: ped.id, plano: ped.plano, valor: ped.valor, criado_em: new Date().toISOString(),
                  gateway: "mercadopago", pix_copia: pm.qr_code, pix_qr: png, pix_expira: exp.toISOString() });
  }

  return json({ erro: "ACAO" }, 400);
});
