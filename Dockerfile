FROM alpine:3.3

RUN apk add --no-cache nginx logrotate supervisor

ADD conf/logrotate.conf /etc/logrotate.d/nginx
ADD conf/supervisor.nginx.conf /etc/supervisor.d/nginx.ini
ADD conf/supervisor.cron.conf /etc/supervisor.d/cron.ini

EXPOSE 80

VOLUME /var/log/nginx/

ENTRYPOINT [ "/usr/bin/supervisord" ]
