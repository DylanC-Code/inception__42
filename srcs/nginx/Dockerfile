FROM alpine:3.20

RUN apk update && \ 
    apk upgrade && \
    apk add --no-cache \
    nginx \
    openssl \
    curl

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./proxy_params /etc/nginx/proxy_params

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]