const fs = require('fs');
const path = '/app/dist/index.html';

if (fs.existsSync(path)) {
    let html = fs.readFileSync(path, 'utf8');

    // 1. Cambiar título de la pestaña
    html = html.replace('<title>Uptime Kuma</title>', '<title>7 SEC MEDIA</title>');

    // 2. Inyectar estilos para branding en el Header (Solo el Logo, sin texto)
    const customStyle = `<style>
header object, 
header object.bi, 
header object[data*="icon.svg"] { 
    display: none !important; 
} 
header a.d-flex::before { 
    content: ""; 
    display: inline-block; 
    width: 60px; 
    height: 42px; 
    background: url("/logo.png") no-repeat center; 
    background-size: contain; 
    margin-right: 10px; 
    margin-left: 15px; 
    vertical-align: middle; 
} 
header span.title { 
    display: none !important; 
}
</style></head>`;

    html = html.replace('</head>', customStyle);

    fs.writeFileSync(path, html, 'utf8');
    console.log('[✓] 7 SEC MEDIA logo-only branding parcheado exitosamente en index.html');
} else {
    console.error('[!] No se encontró /app/dist/index.html');
    process.exit(1);
}
