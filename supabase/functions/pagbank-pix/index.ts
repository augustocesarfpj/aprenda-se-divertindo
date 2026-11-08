// Aprenda se Divertindo · Edge Function "pagbank-pix"
// Gera o Pix do Premium pelo PagBank e libera o Premium sozinho quando o pagamento cai.
//
// Segredos (Supabase → Edge Functions → Secrets). NUNCA coloque o token no site nem no chat:
//   PAGBANK_TOKEN  token da API do PagBank
//   PAGBANK_ENV    "sandbox" para testes ou "producao" (padrão: producao)
// SUPABASE_URL e SUPABASE_SERVICE_ROLE_KEY já existem automaticamente nas Edge Functions.
//
// Publique com "Verify JWT" DESLIGADO: o PagBank chama o aviso (webhook) sem login.
// Mesmo assim, ninguém consegue liberar Premium de mentira: a função sempre pergunta ao PagBank,
// com o seu token, se o pedido foi pago e confere o valor antes de liberar.
//
// Chamadas:
//   POST {acao:"criar", plano, cpf, nome}  (com o login do jogador)  → gera o Pix
//   POST {acao:"verificar"}                (com o login do jogador)  → pergunta ao PagBank se já pagou
//   POST ?wh=1                             (o PagBank chama)         → aviso de pagamento

import { createClient } from "https://esm.sh/@supabase/supabase-js@2.49.4";

const TOKEN = Deno.env.get("PAGBANK_TOKEN") ?? "";
const API = (Deno.env.get("PAGBANK_ENV") ?? "producao").toLowerCase().startsWith("sand")
  ? "https://sandbox.api.pagseguro.com"
  : "https://api.pagseguro.com";
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

// data no fuso de Brasília (-03:00), como o PagBank pede
function brt(d: Date) {
  return new Date(d.getTime() - 3 * 3600e3).toISOString().slice(0, 19) + "-03:00";
}

async function pb(path: string, init: RequestInit = {}) {
  const r = await fetch(API + path, {
    ...init,
    headers: { Authorization: "Bearer " + TOKEN, "Content-Type": "application/json", accept: "application/json", ...(init.headers ?? {}) },
  });
  const t = await r.text();
  let b: any = null;
  try { b = JSON.parse(t); } catch { b = { raw: t.slice(0, 500) }; }
  return { ok: r.ok, status: r.status, body: b };
}

// soma, em centavos, o que já foi pago nas cobranças do pedido
function pagoCentavos(order: any) {
  return (order?.charges ?? [])
    .filter((c: any) => c?.status === "PAID")
    .reduce((s: number, c: any) => s + (Number(c?.amount?.summary?.paid ?? c?.amount?.value) || 0), 0);
}

async function conferir(orderId: string) {
  if (!/^ORDE_[A-Za-z0-9-]+$/.test(orderId)) return { ok: false, motivo: "ID" };
  const r = await pb("/orders/" + orderId);
  if (!r.ok) return { ok: false, motivo: "PAGBANK_" + r.status };
  const pago = pagoCentavos(r.body);
  if (pago <= 0) return { ok: false, motivo: "NAO_PAGO" };
  const { data, error } = await db.rpc("pagbank_confirmar", { p_order: orderId, p_centavos: pago });
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

  // ---- aviso do PagBank ----
  if (url.searchParams.get("wh") === "1") {
    const id = String(body?.id ?? "");
    const r = await conferir(id);
    console.log("webhook", id, JSON.stringify(r));
    return json({ recebido: true }); // sempre 200 para o PagBank não ficar repetindo
  }

  const user = await usuario(req);
  if (!user) return json({ erro: "LOGIN" }, 401);

  // ---- o site pergunta se já pagou ----
  if (body.acao === "verificar") {
    const { data: p } = await db.rpc("pagbank_pedido_do", { p_user: user.id });
    if (!p?.order) return json({ status: "sem_pedido" });
    if (p.status === "confirmado") return json({ status: "confirmado" });
    if (p.status !== "pendente") return json({ status: p.status });
    const r: any = await conferir(p.order);
    return json({ status: r?.ok ? "confirmado" : "pendente" });
  }

  // ---- gerar o Pix ----
  if (body.acao === "criar") {
    const cpf = String(body.cpf ?? "").replace(/\D/g, "");
    if (!cpfOk(cpf)) return json({ erro: "CPF" }, 400);
    const { data: ped, error } = await db.rpc("pagbank_novo_pedido", { p_user: user.id, p_plano: String(body.plano ?? "") });
    if (error) return json({ erro: (error.message.match(/[A-Z_]{5,}/) ?? ["BANCO"])[0] }, 400);
    const nome = String(body.nome ?? "").replace(/[^\p{L} .'-]/gu, "").replace(/\s+/g, " ").trim().slice(0, 120)
      || ped.nome || String(ped.email ?? user.email ?? "Jogador").split("@")[0];
    const expira = new Date(Date.now() + 30 * 60e3);
    const r = await pb("/orders", {
      method: "POST",
      body: JSON.stringify({
        reference_id: ped.id,
        customer: { name: nome, email: ped.email ?? user.email, tax_id: cpf },
        items: [{ reference_id: ped.plano, name: "Premium " + ped.plano + " - Aprenda se Divertindo", quantity: 1, unit_amount: ped.centavos }],
        qr_codes: [{ amount: { value: ped.centavos }, expiration_date: brt(expira) }],
        notification_urls: [SB_URL + "/functions/v1/pagbank-pix?wh=1"],
      }),
    });
    const qr = r.body?.qr_codes?.[0];
    if (!r.ok || !qr?.text) {
      await db.from("pagamentos").update({ status: "cancelado", decidido_em: new Date().toISOString(), obs: "PagBank não gerou o Pix" }).eq("id", ped.id);
      const msg = (r.body?.error_messages ?? []).map((e: any) => [e.code, e.description, e.parameter_name].filter(Boolean).join(" ")).join("; ");
      console.log("criar falhou", r.status, JSON.stringify(r.body));
      return json({ erro: "PAGBANK", detalhe: msg || "HTTP " + r.status }, 502);
    }
    const png = (qr.links ?? []).find((l: any) => /PNG/i.test(l.rel ?? ""))?.href ?? null;
    const exp = qr.expiration_date ? new Date(qr.expiration_date) : expira;
    await db.rpc("pagbank_registrar", { p_id: ped.id, p_order: r.body.id, p_copia: qr.text, p_qr: png, p_expira: exp.toISOString() });
    return json({ id: ped.id, plano: ped.plano, valor: ped.valor, criado_em: new Date().toISOString(),
                  gateway: "pagbank", pix_copia: qr.text, pix_qr: png, pix_expira: exp.toISOString() });
  }

  return json({ erro: "ACAO" }, 400);
});
