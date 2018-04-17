#/bin/bash -ex

mkdir -p /etc/nginx/ssl/

if [ "$LOG_STDOUT" = "true" ]
then
    ln -sfv /dev/stdout /var/log/nginx/access.log
    ln -sfv /dev/stderr /var/log/nginx/error.log
fi

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
    else
        yes y | /usr/local/bin/certbot-auto renew
    fi
fi

exec /usr/bin/supervisord
