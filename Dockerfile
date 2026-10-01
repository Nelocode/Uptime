# Imagen base oficial de Uptime Kuma v2
FROM louislam/uptime-kuma:2

# Reemplazar todos los iconos y logos del frontend (navbar, favicons, PWA)
COPY logo.png /app/dist/icon.png
COPY logo.png /app/dist/icon-192.png
COPY logo.png /app/dist/icon-512.png
COPY logo.png /app/dist/apple-touch-icon.png
COPY icon.svg /app/dist/icon.svg

# Inyectar branding en index.html:
# 1. Cambiar título a 7 SEC MEDIA
# 2. Ocultar el texto "Uptime Kuma" del navbar (el logo ya incluye las letras "7 SEC MEDIA")
# 3. Ajustar tamaño del logo en la barra superior
RUN sed -i 's/<title>Uptime Kuma<\/title>/<title>7 SEC MEDIA<\/title>/g' /app/dist/index.html && \
    sed -i 's/<\/head>/<style>.navbar-brand span { display: none !important; } .navbar-brand img { height: 38px !important; width: auto !important; max-height: 38px !important; }<\/style><\/head>/g' /app/dist/index.html

EXPOSE 3001
