FROM debian:bookworm

RUN apt update && apt install -y nginx openssl

# Crear carpeta para el certificado y generarlo
RUN mkdir -p /etc/nginx/ssl && rm -f /etc/nginx/sites-enabled/default
RUN openssl req -x509 -nodes -days 365 -addext "subjectAltName=DNS:mdoudi-b.42.fr" -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=ES/ST=Malaga/L=Malaga/O=42/OU=42/CN=mdoudi-b.42.fr/UID=mdoudi-b"

# Copiar nuestra configuración
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Ejecutar Nginx en primer plano (importante para que el contenedor no muera)
CMD ["nginx", "-g", "daemon off;"]
