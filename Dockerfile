# Imagen base oficial de Uptime Kuma v2
FROM louislam/uptime-kuma:2

# Copiar el logotipo de 7 SEC MEDIA
COPY logo.png /app/dist/logo.png
COPY logo.png /app/dist/icon.png
COPY logo.png /app/dist/icon-192.png
COPY logo.png /app/dist/icon-512.png
COPY logo.png /app/dist/apple-touch-icon.png
COPY icon.svg /app/dist/icon.svg

# Eliminar assets precomprimidos (gzip/brotli) para evitar servir iconos viejos en caché
RUN find /app -name "*icon*.gz" -delete || true && \
    find /app -name "*icon*.br" -delete || true && \
    find /app -name "icon.svg" -exec cp /app/dist/icon.svg {} \; && \
    find /app -name "icon.png" -exec cp /app/dist/logo.png {} \;

# Inyectar estilos en index.html para:
# 1. Ocultar el objeto SVG del osito
# 2. Insertar directamente el logo /logo.png de 7 SEC MEDIA
# 3. Reemplazar el texto "Uptime Kuma" por "7 SEC MEDIA"
# 4. Actualizar el título de la pestaña
RUN sed -i 's/<title>Uptime Kuma<\/title>/<title>7 SEC MEDIA<\/title>/g' /app/dist/index.html && \
    sed -i 's#</head>#<style>header object, header object.bi, header object[data*="icon.svg"] { display: none !important; } header a.d-flex::before { content: ""; display: inline-block; width: 52px; height: 36px; background: url("/logo.png") no-repeat center; background-size: contain; margin-right: 10px; margin-left: 15px; vertical-align: middle; } header span.title { visibility: hidden !important; position: relative !important; display: inline-block !important; } header span.title::after { visibility: visible !important; position: absolute !important; top: 0 !important; left: 0 !important; content: "7 SEC MEDIA" !important; white-space: nowrap !important; font-weight: 700 !important; color: #fff !important; }</style></head>#g' /app/dist/index.html

EXPOSE 3001
