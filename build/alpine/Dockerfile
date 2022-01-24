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

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# Copy required files
COPY build/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY server-configs-nginx/h5bp /usr/local/openresty/nginx/conf/h5bp
COPY server-configs-nginx/mime.types /usr/local/openresty/nginx/conf/mime.types
