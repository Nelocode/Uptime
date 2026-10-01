# Imagen base oficial de Uptime Kuma
FROM louislam/uptime-kuma:1

# Hornear el logotipo oficial de 7 SEC MEDIA directamente en la imagen
COPY logo.png /app/dist/icon.png
COPY logo.png /app/dist/icon-192.png
COPY logo.png /app/dist/icon-512.png
COPY logo.png /app/dist/apple-touch-icon.png

# Puerto por defecto de Uptime Kuma
EXPOSE 3001
