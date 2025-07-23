FROM alpine:3.20 AS builder

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    nodejs \
    git \
    npm \
    curl

WORKDIR /portfolio

RUN git clone https://github.com/DylanC-Code/portfolio.git . && \
    npm install && \
    npm run build


FROM alpine:3.20 

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    nginx

COPY --from=builder /portfolio/build /var/www
COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]