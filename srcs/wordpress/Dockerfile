FROM alpine:3.20

RUN apk update && \ 
    apk upgrade && \
    apk add --no-cache \
    iproute2-ss \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-mbstring \
    php82-json \
    php82-session \
    php82-zlib \
    php82-curl \
    php82-opcache \
    php82-exif \
    php82-gd \
    php82-dom \
    php82-fileinfo \
    php82-tokenizer \
    php82-xml \
    php82-simplexml \
    php82-phar \
    curl \
    bash \
    openrc \
    supervisor

RUN ln -s /usr/bin/php82 /usr/bin/php && \
    sed -i 's|^listen = .*|listen = 9000|' /etc/php82/php-fpm.d/www.conf

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

COPY ./php.ini /etc/php82/php.ini
COPY ./entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9000
EXPOSE 8000

WORKDIR /var/www/

ENTRYPOINT [ "/docker-entrypoint.sh" ]