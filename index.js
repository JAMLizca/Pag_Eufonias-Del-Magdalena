  function flipCard(id) {
    document.getElementById(id).classList.toggle('is-flipped');
  }

  // Animación de números de impacto
  document.addEventListener("DOMContentLoaded", () => {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const element = entry.target.querySelector('.stat-value');
          const target = parseInt(element.getAttribute('data-val'));
          animateNumber(element, target);
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.5 });

    document.querySelectorAll('.stat-card').forEach(card => observer.observe(card));

    function animateNumber(obj, target) {
      let start = null;
      const duration = 2000;
      const step = (timestamp) => {
        if (!start) start = timestamp;
        const progress = Math.min((timestamp - start) / duration, 1);
        const easeOut = progress * (2 - progress);
        const val = Math.floor(easeOut * target);
        
        if(target === 50) obj.innerHTML = "+" + val;
        else if(target === 100 && obj.classList.contains('text-verde')) obj.innerHTML = val + "%";
        else obj.innerHTML = "+" + val;

        if (progress < 1) window.requestAnimationFrame(step);
      };
      window.requestAnimationFrame(step);
    }
  });

  // Datos de historias para el modal
  const historiasData = {
    proceso: {
        titulo: 'Del Grano a la Taza',
        cuerpo: 'Las recolectoras seleccionan manualmente los frutos más maduros. Luego pasamos al despulpe y un secado controlado que garantiza aroma y sabor.',
        color: '#f5c311'
    },
    liderazgo: {
        titulo: 'Mujeres del Magdalena',
        cuerpo: 'Eufonías ha capacitado a más de 50 mujeres en técnicas de catación y barismo, empoderándolas como dueñas de su destino.',
        color: '#e0465f'
    },
    sostenibilidad: {
        titulo: 'Compromiso Ambiental',
        cuerpo: 'Cultivamos bajo sombra de árboles nativos y convertimos la pulpa en abono orgánico para nutrir la tierra de forma natural.',
        color: '#86b872'
    }
  };

  function cargarContenido(tipo) {
    const data = historiasData[tipo];
    const contenedor = document.getElementById('contenido-dinamico');
    contenedor.innerHTML = `
        <h6 class="text-uppercase fw-bold mb-2" style="color: ${data.color}">Historia de ${tipo}</h6>
        <h2 class="display-6 fw-bold mb-4">${data.titulo}</h2>
        <p class="lead text-muted" style="line-height: 1.8;">${data.cuerpo}</p>
    `;
  }