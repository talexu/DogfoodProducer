FROM ubuntu:14.04
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        nginx \
        nginx-extras \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /usr/local/etc \
    && { \
      echo 'install: --no-document'; \
      echo 'update: --no-document'; \
    } >> /usr/local/etc/gemrc \
    && mkdir -p /opt/vcam/dogfood_producer/current/tmp/pids \
    && mkdir -p /opt/vcam/dogfood_producer/current/log
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
