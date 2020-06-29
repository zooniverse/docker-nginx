ARG VERSION
FROM nginx:$VERSION

RUN mkdir -p /etc/nginx-sites

COPY nginx.conf /etc/nginx/nginx.conf