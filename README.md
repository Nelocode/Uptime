# Uptime Kuma — 7 SEC MEDIA Branding

Este paquete contiene la configuración lista para desplegar **Uptime Kuma** en tu VPS con la marca **7 SEC MEDIA**.

## 🚀 Opción 1: Instalación Rápida con 1 Solo Comando en tu VPS

Conéctate por SSH a tu VPS y ejecuta:

```bash
# Copia y pega el contenido del archivo setup-vps.sh en tu VPS:
nano setup-vps.sh
# (Pega el contenido, guarda con Ctrl+O, Enter y sal con Ctrl+X)
sudo bash setup-vps.sh
```

El script automáticamente:
1. Instala Docker y Docker Compose (si no están instalados).
2. Crea `/opt/uptime-kuma-7sec/`.
3. Extrae y configura el logotipo oficial de **7 SEC MEDIA**.
4. Despliega Uptime Kuma montando los iconos para white-label del panel interno.
5. Inicia el servicio en el puerto `3001`.

---

## 🛠️ Opción 2: Subir esta carpeta a tu VPS manualmente

Desde tu Mac, puedes sincronizar la carpeta con `rsync` o `scp`:

```bash
rsync -avz ./uptime-kuma-7sec root@TU_IP_VPS:/opt/
```

Luego en el VPS:
```bash
cd /opt/uptime-kuma-7sec
docker compose up -d
```

---

## 🔒 Configurar Dominio y SSL (HTTPS)

### Con Caddy (Recomendado, SSL automático)
En [docker-compose.yml](file:///Users/i2carvajal/Documents/Proyectos/Procesos%20Matrix/uptime-kuma-7sec/docker-compose.yml):
1. Descomenta las líneas del servicio `caddy`.
2. En [Caddyfile](file:///Users/i2carvajal/Documents/Proyectos/Procesos%20Matrix/uptime-kuma-7sec/Caddyfile), reemplaza `status.7secmedia.com` por tu dominio.
3. Apunta el registro DNS de tu subdominio (tipo A) a la IP de tu VPS.
4. Ejecuta `docker compose up -d`. ¡Caddy generará el certificado SSL gratis automáticamente!

### Con Nginx Proxy existente
Si ya tienes Nginx en tu VPS:
```nginx
server {
    server_name status.7secmedia.com;

    location / {
        proxy_pass http://127.0.0.1:3001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # WebSockets
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

---

## 🎨 Branding de Páginas de Estado Públicas

1. En el panel (http://TU_IP:3001), ve a **Páginas de Estado** -> **Nueva página de estado**.
2. Sube el archivo `logo.png` que está en esta carpeta como Logo y Favicon.
3. En la sección **Custom CSS**, copia el contenido de [custom.css](file:///Users/i2carvajal/Documents/Proyectos/Procesos%20Matrix/uptime-kuma-7sec/custom.css).
4. Guarda y ¡listo! Tendrás tu página pública con la marca 7 SEC MEDIA y sin menciones a Uptime Kuma.
