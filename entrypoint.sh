#/bin/bash -e

mkdir -p /etc/nginx/ssl/

if [ -z "$CERTBOT_VHOST" ]
then
    openssl req \
        -new \
        -newkey rsa:4096 \
        -days 365 \
        -nodes \
        -x509 \
        -subj "/C=NA/ST=NA/L=NA/O=NA/CN=$(hostname)" \
        -keyout /etc/nginx/ssl/key.pem \
        -out /etc/nginx/ssl/cert.pem
else
    if [ ! -f /etc/nginx/ssl/cert.pem ]
    then
        yes y | /usr/local/bin/certbot-auto certonly \
            --standalone \
            --no-self-upgrade \
            --agree-tos \
            --email sysadmins@zooniverse.org \
            -n \
            -d ${CERTBOT_VHOST}
        ln -s /etc/letsencrypt/live/${$CERTBOT_VHOST}/privkey.pem /etc/nginx/ssl/key.pem
        ln -s /etc/letsencrypt/live/${$CERTBOT_VHOST}/fullchain.pem /etc/nginx/ssl/cert.pem
    fi
fi

exec /usr/bin/supervisord
