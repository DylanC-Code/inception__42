FROM alpine:3.20

RUN apk update && \ 
    apk upgrade && \
    apk add --no-cache nginx openssl

COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]