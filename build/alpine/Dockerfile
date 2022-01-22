ARG VERSION=alpine-fat
FROM openresty/openresty:${VERSION}

ENV USER=www-data

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --ingroup "$USER" \
    --no-create-home \
    "$USER"

RUN mkdir -p /var/log/nginx/

# Copy required files
COPY server-configs-nginx/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY server-configs-nginx/h5bp /usr/local/openresty/nginx/conf/h5bp
COPY server-configs-nginx/mime.types /usr/local/openresty/nginx/conf/mime.types
