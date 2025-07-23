FROM alpine:3.20

RUN apk update && \ 
    apk upgrade && \
    apk add --no-cache \
    vsftpd \
    shadow    

RUN useradd -m -d "/home/ftpuser" -s /sbin/nologin ftpuser && \
    chown -R ftpuser:ftpuser /home/ftpuser

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 21 21100-21110

ENTRYPOINT ["/entrypoint.sh"]
