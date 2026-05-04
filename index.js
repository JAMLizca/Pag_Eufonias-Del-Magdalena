document.addEventListener("DOMContentLoaded", () => {
    // 1. Efecto de seguimiento del mouse
    const cards = document.querySelectorAll('.stat-card');
    cards.forEach(card => {
        card.addEventListener('mousemove', e => {
            const rect = card.getBoundingClientRect();
            card.style.setProperty('--x', `${e.clientX - rect.left}px`);
            card.style.setProperty('--y', `${e.clientY - rect.top}px`);
        });
    });

    // 2. Función de animación de números
    const runCounter = (el) => {
        const target = parseInt(el.getAttribute('data-val'));
        let current = 0;
        const increment = target / 50; // Velocidad del conteo
        
        const update = () => {
            current += increment;
            if (current < target) {
                el.innerText = el.classList.contains('text-verde') ? 
                    Math.ceil(current) + "%" : "+" + Math.ceil(current);
                requestAnimationFrame(update);
            } else {
                el.innerText = el.classList.contains('text-verde') ? 
                    target + "%" : "+" + target;
            }
        };
        update();
    };

    // 3. Activar cuando sea visible
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const valEl = entry.target.querySelector('.stat-value');
                if (valEl) runCounter(valEl);
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });

    cards.forEach(c => observer.observe(c));
});
