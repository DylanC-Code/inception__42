FROM alpine:3.20

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    php82 \
    php82-session \
    php82-mysqli \
    php82-pdo \
    php82-pdo_mysql \
    php82-mbstring \
    php82-json \
    curl

RUN mkdir -p /var/www/html && \
    curl -L --output /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v5.3.0/adminer-5.3.0.php   

WORKDIR /var/www/html

EXPOSE 8080

CMD ["php82", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]