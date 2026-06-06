/* Mouse Click Ripple & Cursor Move Trail Animation Effect */

document.addEventListener('DOMContentLoaded', () => {
    // 1. Mouse Click Ripple Effect
    document.addEventListener('click', (e) => {
        const ripple = document.createElement('div');
        ripple.className = 'click-ripple';
        
        // Position at cursor center
        ripple.style.left = `${e.pageX}px`;
        ripple.style.top = `${e.pageY}px`;
        
        document.body.appendChild(ripple);
        
        // Remove after animation finishes
        setTimeout(() => {
            ripple.remove();
        }, 500);
    });

    // 2. Cursor Move Trail Effect
    let lastX = 0;
    let lastY = 0;
    
    // Color palette for particle trail (lively & vibrant colors)
    const colors = [
        'rgba(0, 134, 246, 0.7)',  // Ctrip Blue
        'rgba(255, 154, 20, 0.7)', // Ctrip Orange
        'rgba(16, 185, 129, 0.7)', // Success Green
        'rgba(165, 243, 252, 0.8)'  // Glow Blue-cyan
    ];

    document.addEventListener('mousemove', (e) => {
        // Calculate distance moved
        const distance = Math.hypot(e.pageX - lastX, e.pageY - lastY);
        
        // Only spawn particle if mouse has moved at least 15 pixels
        if (distance > 15) {
            createParticle(e.pageX, e.pageY);
            lastX = e.pageX;
            lastY = e.pageY;
        }
    });

    function createParticle(x, y) {
        const particle = document.createElement('div');
        particle.className = 'trail-particle';
        
        // Random size between 6px and 12px
        const size = Math.floor(Math.random() * 7) + 6;
        particle.style.width = `${size}px`;
        particle.style.height = `${size}px`;
        
        // Position at cursor
        particle.style.left = `${x}px`;
        particle.style.top = `${y}px`;
        
        // Random color selection
        const randomColor = colors[Math.floor(Math.random() * colors.length)];
        particle.style.background = randomColor;
        
        document.body.appendChild(particle);
        
        // Remove from DOM after animation finishes (800ms)
        setTimeout(() => {
            particle.remove();
        }, 800);
    }
});
