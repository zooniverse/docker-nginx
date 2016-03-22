#/bin/bash -e

mkdir -p /etc/nginx/ssl/
openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=NA/ST=NA/L=NA/O=NA/CN=$(hostname)" \
    -keyout /etc/nginx/ssl/key.pem \
    -out /etc/nginx/ssl/cert.pem

exec /usr/bin/supervisord
