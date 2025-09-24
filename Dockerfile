# This arg must be declared but should never be used.
# Version is set via build arg in the build_image workflow.
# If that version doesn't exist, the build should fail.
ARG VERSION=invalid
FROM nginx:$VERSION

# Required to parse Azure JSON
RUN apt-get update && apt-get install -y jq && apt-get clean

RUN mkdir -p /etc/nginx-sites
RUN echo "listen 80;" > /etc/nginx/listen.default.conf
# This image doesn't actually configure SSL but the following symlink is for backwards compatibility
RUN ln -s /etc/nginx/listen.default.conf /etc/nginx/ssl.default.conf

COPY nginx.conf /etc/nginx/nginx.conf

# Generate a list of Azure Front Door IPs and create an
# optionally includable set of set_real_ip_from directives
COPY generate-azure-directives.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/generate-azure-directives.sh && /usr/local/bin/generate-azure-directives.sh
RUN rm -f /usr/local/bin/generate-azure-directives.sh
