FROM alpine:3.20

RUN apk update && \ 
    apk upgrade && \
    apk add --no-cache \
    vsftpd \
    shadow

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 21 21100-21110

VOLUME [ "/home/ftpuser" ]

ENTRYPOINT ["/entrypoint.sh"]
