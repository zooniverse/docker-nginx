ARG VERSION
FROM nginx:$VERSION

RUN mkdir -p /etc/nginx-sites
RUN echo "listen 80;" > /etc/nginx/listen.default.conf
# This image doesn't actually configure SSL but the following symlink is for backwards compatibility
RUN ln -s /etc/nginx/listen.default.conf /etc/nginx/ssl.default.conf

COPY nginx.conf /etc/nginx/nginx.conf