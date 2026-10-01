# Imagen base oficial de Uptime Kuma v2
FROM louislam/uptime-kuma:2

# Copiar archivos de branding a /tmp para evitar conflictos de sobreescritura
COPY logo.png /tmp/logo.png
COPY icon.svg /tmp/icon.svg

# 1. Copiar los logos a la carpeta estática
RUN cp /tmp/logo.png /app/dist/logo.png && \
    cp /tmp/logo.png /app/dist/icon.png && \
    cp /tmp/logo.png /app/dist/icon-192.png && \
    cp /tmp/logo.png /app/dist/icon-512.png && \
    cp /tmp/logo.png /app/dist/apple-touch-icon.png && \
    cp /tmp/icon.svg /app/dist/icon.svg

# 2. Eliminar archivos comprimidos pre-generados para forzar el uso de nuestros archivos
RUN rm -f /app/dist/icon*.gz /app/dist/icon*.br 2>/dev/null || true

# 3. Inyectar branding en index.html:
# - Reemplazar título
# - Ocultar el osito
# - Mostrar logo de 7 SEC MEDIA con /logo.png
# - Reemplazar el texto "Uptime Kuma" por "7 SEC MEDIA"
RUN sed -i 's/<title>Uptime Kuma<\/title>/<title>7 SEC MEDIA<\/title>/g' /app/dist/index.html && \
    sed -i 's#</head>#<style>header object, header object.bi, header object[data*="icon.svg"] { display: none !important; } header a.d-flex::before { content: ""; display: inline-block; width: 52px; height: 36px; background: url("/logo.png") no-repeat center; background-size: contain; margin-right: 10px; margin-left: 15px; vertical-align: middle; } header span.title { visibility: hidden !important; position: relative !important; display: inline-block !important; } header span.title::after { visibility: visible !important; position: absolute !important; top: 0 !important; left: 0 !important; content: "7 SEC MEDIA" !important; white-space: nowrap !important; font-weight: 700 !important; color: #fff !important; }</style></head>#g' /app/dist/index.html

EXPOSE 3001
