# Imagen base oficial de Uptime Kuma v2
FROM louislam/uptime-kuma:2

# Copiar archivos a /tmp
COPY logo.png /tmp/logo.png
COPY icon.svg /tmp/icon.svg
COPY patch.js /tmp/patch.js

# 1. Copiar assets a la carpeta estática
RUN cp /tmp/logo.png /app/dist/logo.png && \
    cp /tmp/logo.png /app/dist/icon.png && \
    cp /tmp/logo.png /app/dist/icon-192.png && \
    cp /tmp/logo.png /app/dist/icon-512.png && \
    cp /tmp/logo.png /app/dist/apple-touch-icon.png && \
    cp /tmp/icon.svg /app/dist/icon.svg

# 2. Eliminar versiones comprimidas viejas
RUN rm -f /app/dist/icon*.gz /app/dist/icon*.br 2>/dev/null || true

# 3. Aplicar parche de branding con Node.js de forma 100% segura
RUN node /tmp/patch.js && rm /tmp/patch.js

EXPOSE 3001
