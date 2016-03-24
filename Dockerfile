FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y -q software-properties-common && \
    add-apt-repository ppa:nginx/stable && \
    apt-get update && \
    apt-get -y -q install nginx logrotate supervisor openssl && \
    rm -rf /var/lib/apt/lists/*

ADD conf/logrotate.conf /etc/logrotate.d/nginx
ADD conf/supervisor.nginx.conf /etc/supervisor/conf.d/nginx.conf
ADD conf/supervisor.cron.conf /etc/supervisor/conf.d/cron.conf
ADD conf/ssl.default.conf /etc/nginx/ssl.default.conf
ADD entrypoint.sh /entrypoint.sh

EXPOSE 80

VOLUME /var/log/nginx/

ENTRYPOINT /entrypoint.sh
