FROM alpine:3.20

RUN apk update && \ 
    apk upgrade && \
    apk add --no-cache \
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

RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress /var/www/ && \
    rm latest.tar.gz

COPY ./setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 9000

WORKDIR /var/www/

RUN /usr/local/bin/setup.sh

CMD ["php-fpm82", "--nodaemonize"]