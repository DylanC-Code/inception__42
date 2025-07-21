FROM alpine:3.20

RUN apk update && \ 
    apk upgrade && \
    apk add --no-cache nginx openssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/ssl /etc/nginx/ssl

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]