FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y -q install nginx

EXPOSE 80

VOLUME /var/log/nginx/

ENTRYPOINT /usr/sbin/nginx -g "daemon off;"
