document.addEventListener("DOMContentLoaded", () => {

  /*  CURSOR PERSONALIZADO */
  const dot  = document.createElement("div");
  const ring = document.createElement("div");
  dot.className  = "cursor-dot";
  ring.className = "cursor-ring";
  document.body.append(dot, ring);

  let mouseX = 0, mouseY = 0;
  let ringX  = 0, ringY  = 0;

  document.addEventListener("mousemove", e => {
    mouseX = e.clientX;
    mouseY = e.clientY;
    dot.style.left = mouseX + "px";
    dot.style.top  = mouseY + "px";
  });

  // El ring sigue con inercia (lerp)
  (function lerpRing() {
    ringX += (mouseX - ringX) * 0.12;
    ringY += (mouseY - ringY) * 0.12;
    ring.style.left = ringX + "px";
    ring.style.top  = ringY + "px";
    requestAnimationFrame(lerpRing);
  })();

  // Agrandar el ring sobre elementos interactivos
  const interactivos = "a, button, .producto-card, .story-entry, .stat-card, .nav-link";
  document.querySelectorAll(interactivos).forEach(el => {
    el.addEventListener("mouseenter", () => ring.classList.add("hover"));
    el.addEventListener("mouseleave", () => ring.classList.remove("hover"));
  });

  /*  BRILLO QUE SIGUE AL MOUSE EN STAT-CARDS */
  document.querySelectorAll(".stat-card").forEach(card => {
    card.addEventListener("mousemove", e => {
      const rect = card.getBoundingClientRect();
      card.style.setProperty("--x", `${e.clientX - rect.left}px`);
      card.style.setProperty("--y", `${e.clientY - rect.top}px`);
    });
  });

  /* CONTADORES ANIMADOS (easing suave) */
  const easeOut = t => 1 - Math.pow(1 - t, 3); // Cúbica de desaceleración

  const animateCounter = (el) => {
    const target   = parseInt(el.dataset.val);
    const isVerde  = el.classList.contains("text-verde");
    const duration = 1800; // ms
    const start    = performance.now();

    const tick = (now) => {
      const elapsed  = now - start;
      const progress = Math.min(elapsed / duration, 1);
      const value    = Math.ceil(easeOut(progress) * target);

      el.textContent = isVerde ? value + "%" : "+" + value;

      if (progress < 1) requestAnimationFrame(tick);
    };

    requestAnimationFrame(tick);
  };

  const counterObserver = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const valEl = entry.target.querySelector(".stat-value");
        if (valEl) animateCounter(valEl);
        counterObserver.unobserve(entry.target);
      }
    });
  }, { threshold: 0.5 });

  document.querySelectorAll(".stat-card").forEach(c => counterObserver.observe(c));

  /* SCROLL REVEAL GENERAL (data-reveal)*/
  const revealObserver = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add("revealed");
        revealObserver.unobserve(entry.target);
      }
    });
  }, { threshold: 0.15 });

  document.querySelectorAll("[data-reveal]").forEach(el => revealObserver.observe(el));

  /* NAVBAR: ocultar/mostrar al hacer scroll */
  let lastScroll = 0;
  const navbar   = document.querySelector(".navbar-custom");

  window.addEventListener("scroll", () => {
    const current = window.scrollY;
    if (current > lastScroll && current > 120) {
      // Scrolleando hacia abajo: ocultar suavemente
      navbar.style.transform = "translateY(-100%)";
    } else {
      // Scrolleando hacia arriba: mostrar
      navbar.style.transform = "translateY(0)";
    }
    lastScroll = current;
  }, { passive: true });

  // Asegurar transición CSS para la navbar
  navbar.style.transition = "transform 0.4s cubic-bezier(0.4, 0, 0.2, 1)";

  /* NAVBAR: active link según sección visible */
  const sections  = document.querySelectorAll("section[id]");
  const navLinks  = document.querySelectorAll(".nav-link");

  const sectionObserver = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        navLinks.forEach(link => link.classList.remove("active"));
        const activeLink = document.querySelector(`.nav-link[href="#${entry.target.id}"]`);
        if (activeLink) activeLink.classList.add("active");
      }
    });
  }, { threshold: 0.4 });

  sections.forEach(s => sectionObserver.observe(s));

  /* PARTÍCULAS FLOTANTES EN #IMPACTO  */
  const impactoSection = document.getElementById("impacto");
  if (impactoSection) {
    for (let i = 0; i < 18; i++) {
      const p = document.createElement("span");
      p.className = "particula";
      Object.assign(p.style, {
        position:     "absolute",
        borderRadius: "50%",
        opacity:      Math.random() * 0.25 + 0.05,
        width:        Math.random() * 6 + 3 + "px",
        height:       p.style.width,
        left:         Math.random() * 100 + "%",
        top:          Math.random() * 100 + "%",
        background:   ["#e0465f","#f5c311","#86b872"][Math.floor(Math.random()*3)],
        animation:    `flotarParticula ${Math.random()*8+6}s ease-in-out ${Math.random()*5}s infinite alternate`,
        pointerEvents:"none",
      });
      impactoSection.appendChild(p);
    }

    // Keyframes dinámicos para la animación
    if (!document.getElementById("kf-particulas")) {
      const kf = document.createElement("style");
      kf.id = "kf-particulas";
      kf.textContent = `
        @keyframes flotarParticula {
          from { transform: translateY(0) scale(1); }
          to   { transform: translateY(-40px) scale(1.3); }
        }
      `;
      document.head.appendChild(kf);
    }
  }

  /* MODAL DE HISTORIAS — contenido dinámico*/
  window.cargarContenido = (tipo) => {
    const contenidos = {
      proceso: {
        icon:  "☕",
        color: "#e0465f",
        titulo:"Del grano a la taza",
        sub:   "Un viaje sensorial desde las laderas del Magdalena",
        texto: `
          <p>El café de Eufonías del Magdalena recorre un camino lleno de cuidado y tradición.
          Todo comienza en los cafetales, donde las manos expertas de nuestras
          socias seleccionan los mejores granos en el punto exacto de maduración.</p>
          <p>El proceso de beneficio húmedo conserva los azúcares naturales del fruto,
          y el secado al sol bajo la brisa del Magdalena le otorga sus notas únicas de
          frutos tropicales y chocolate.</p>
          <p>Cada taza es el resultado de generaciones de conocimiento transmitido entre mujeres.</p>
        `
      },
      liderazgo: {
        icon:  "👩‍🌾",
        color: "#86b872",
        titulo:"Mujeres Cafeteras",
        sub:   "El liderazgo femenino que está transformando el campo",
        texto: `
          <p>Eufonías del Magdalena nació del sueño de un grupo de mujeres rurales que decidieron
          tomar las riendas de su futuro. Hoy, más de 50 mujeres son las protagonistas de toda
          la cadena productiva: desde el cultivo hasta la comercialización.</p>
          <p>Nuestras asociadas han recibido formación en gestión empresarial, catación de café
          y prácticas agroecológicas, construyendo una organización sólida y autónoma.</p>
          <p>El empoderamiento femenino no es solo nuestro eslogan — es nuestra raíz.</p>
        `
      },
      sostenibilidad: {
        icon:  "🌿",
        color: "#f5c311",
        titulo:"Café Responsable",
        sub:   "Técnicas que protegen nuestra biodiversidad",
        texto: `
          <p>Producimos café bajo sombra diversificada, manteniendo corredores de biodiversidad
          que albergan aves y especies nativas de nuestra región.</p>
          <p>Utilizamos compostaje con pulpa de café, lombricompost y preparados biodinámicos
          que eliminan la necesidad de agroquímicos. El agua residual del beneficio se trata
          con biodigestores artesanales construidos por la propia comunidad.</p>
          <p>Nuestra meta: ser la primera asociación cafetera carbono-neutral del departamento.</p>
        `
      }
    };

    const data = contenidos[tipo];
    if (!data) return;

    document.getElementById("contenido-dinamico").innerHTML = `
      <div class="text-center mb-4">
        <div style="font-size:3.5rem;line-height:1;margin-bottom:12px">${data.icon}</div>
        <h2 class="fw-bold" style="color:${data.color}">${data.titulo}</h2>
        <p class="text-muted">${data.sub}</p>
        <hr style="border-color:${data.color};border-width:3px;width:60px;margin:16px auto">
      </div>
      <div style="font-size:1rem;line-height:1.9;color:#444">${data.texto}</div>
    `;
  };

  /* FORMULARIO DE CONTACTO — feedback visual */
  const form = document.getElementById("formContacto");
  if (form) {
    form.addEventListener("submit", e => {
      e.preventDefault();
      const btn = form.querySelector("button[type='submit']");
      const original = btn.innerHTML;

      btn.disabled   = true;
      btn.innerHTML  = '<span class="spinner-border spinner-border-sm me-2"></span>Enviando...';

      // Simulación de envío (2 s)
      setTimeout(() => {
        btn.innerHTML  = '<i class="bi bi-check-circle-fill me-2"></i>¡Mensaje enviado!';
        btn.style.background = "#86b872";
        form.reset();

        setTimeout(() => {
          btn.innerHTML  = original;
          btn.disabled   = false;
          btn.style.background = "";
        }, 3500);
      }, 2000);
    });
  }

  /* PARALLAX SUTIL en el héroe del carrusel */
  const overlays = document.querySelectorAll(".overlay-modern");
  window.addEventListener("scroll", () => {
    const sy = window.scrollY;
    overlays.forEach(o => {
      o.style.transform = `translateY(${sy * 0.25}px)`;
    });
  }, { passive: true });

}); // fin DOMContentLoaded