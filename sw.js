/* Aprenda se Divertindo: deixa o jogo instalável e abre mesmo sem internet.
   Páginas: rede primeiro, cópia salva se estiver offline (atualizações chegam na hora).
   Ícones e fontes: cópia salva primeiro. Supabase e outros serviços: nunca passam por aqui. */
const VER = "asd-v1";
const BASE = ["./", "index.html", "manifest.webmanifest", "icones/icone-192.png", "icones/icone-512.png", "icones/apple-touch-icon.png", "icones/favicon.svg"];

self.addEventListener("install", e => {
  e.waitUntil(caches.open(VER).then(c => c.addAll(BASE)).then(() => self.skipWaiting()));
});

self.addEventListener("activate", e => {
  e.waitUntil(caches.keys().then(ks => Promise.all(ks.filter(k => k !== VER).map(k => caches.delete(k)))).then(() => self.clients.claim()));
});

self.addEventListener("fetch", e => {
  const r = e.request;
  if (r.method !== "GET") return;
  const u = new URL(r.url);
  const fonte = u.hostname === "fonts.googleapis.com" || u.hostname === "fonts.gstatic.com";
  if (u.origin !== location.origin && !fonte) return;
  if (u.pathname.endsWith("/admin.html")) return;

  if (fonte || u.pathname.includes("/icones/")) {
    e.respondWith(caches.match(r).then(hit => hit || fetch(r).then(res => {
      if (res.ok || res.type === "opaque") { const cp = res.clone(); caches.open(VER).then(c => c.put(r, cp)); }
      return res;
    })));
    return;
  }

  e.respondWith(fetch(r).then(res => {
    if (res.ok) { const cp = res.clone(); caches.open(VER).then(c => c.put(r, cp)); }
    return res;
  }).catch(() => caches.match(r, { ignoreSearch: r.mode === "navigate" }).then(hit => hit || (r.mode === "navigate" ? caches.match("index.html") : Response.error()))));
});
