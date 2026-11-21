/* Aprenda se Divertindo: CAPTCHA (Cloudflare Turnstile, grátis) do Entrar e do Criar conta.
   Só aparece quando a chave do site está salva na administração (Configurações → CAPTCHA).
   Também confere, de graça, se a senha nova já apareceu em vazamentos (Have I Been Pwned):
   só os 5 primeiros caracteres do resumo SHA-1 da senha saem do aparelho; a senha nunca é enviada. */
(function () {
  let carregando = null;
  function lib() {
    if (window.turnstile) return Promise.resolve();
    if (carregando) return carregando;
    carregando = new Promise((ok, erro) => {
      const s = document.createElement("script");
      s.src = "https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit";
      s.async = true;
      s.onload = ok;
      s.onerror = () => { carregando = null; erro(new Error("captcha")); };
      document.head.appendChild(s);
    });
    return carregando;
  }

  window.Captcha = {
    // monta o CAPTCHA dentro de el; devolve {token(), reset()} ou null se não houver chave
    async montar(el, chave) {
      if (!el) return null;
      el.innerHTML = "";
      el.hidden = !chave;
      if (!chave) return null;
      try { await lib(); } catch (e) { el.textContent = "Não foi possível carregar a verificação. Confira a internet e abra de novo."; return { token: () => "", reset() {} }; }
      let tk = "";
      const id = window.turnstile.render(el, {
        sitekey: chave, language: "pt-br", theme: "auto",
        callback: t => { tk = t; },
        "expired-callback": () => { tk = ""; },
        "error-callback": () => { tk = ""; }
      });
      return { token: () => tk, reset() { tk = ""; try { window.turnstile.reset(id); } catch (e) {} } };
    },

    // true se a senha já apareceu em vazamentos conhecidos; em caso de falha de rede, não bloqueia
    async senhaVazada(senha) {
      try {
        const b = new Uint8Array(await crypto.subtle.digest("SHA-1", new TextEncoder().encode(senha)));
        const h = Array.from(b, x => x.toString(16).padStart(2, "0")).join("").toUpperCase();
        const r = await fetch("https://api.pwnedpasswords.com/range/" + h.slice(0, 5), { headers: { "Add-Padding": "true" } });
        if (!r.ok) return false;
        const suf = h.slice(5);
        return (await r.text()).split("\n").some(l => { const [s, c] = l.trim().split(":"); return s === suf && +c > 0; });
      } catch (e) { return false; }
    }
  };
})();
