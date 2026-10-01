const fs = require('fs');
const path = '/app/dist/index.html';

if (fs.existsSync(path)) {
    let html = fs.readFileSync(path, 'utf8');

    // 1. Cambiar título
    html = html.replace('<title>Uptime Kuma</title>', '<title>7 SEC MEDIA</title>');

    // 2. Inyectar estilos para branding en el Header
    const customStyle = `<style>
header object, 
header object.bi, 
header object[data*="icon.svg"] { 
    display: none !important; 
} 
header a.d-flex::before { 
    content: ""; 
    display: inline-block; 
    width: 52px; 
    height: 36px; 
    background: url("/logo.png") no-repeat center; 
    background-size: contain; 
    margin-right: 10px; 
    margin-left: 15px; 
    vertical-align: middle; 
} 
header span.title { 
    visibility: hidden !important; 
    position: relative !important; 
    display: inline-block !important; 
} 
header span.title::after { 
    visibility: visible !important; 
    position: absolute !important; 
    top: 0 !important; 
    left: 0 !important; 
    content: "7 SEC MEDIA" !important; 
    white-space: nowrap !important; 
    font-weight: 700 !important; 
    color: #fff !important; 
}
</style></head>`;

    html = html.replace('</head>', customStyle);

    fs.writeFileSync(path, html, 'utf8');
    console.log('[✓] 7 SEC MEDIA branding parcheado exitosamente en index.html');
} else {
    console.error('[!] No se encontró /app/dist/index.html');
    process.exit(1);
}
