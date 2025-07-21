FROM alpine:3.20

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    mariadb \
    mariadb-client

RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

COPY my.cnf /etc/my.cnf
COPY entrypoint.sh /docker-entrypoint.sh 
RUN chmod +x /docker-entrypoint.sh

VOLUME /var/lib/mysql

EXPOSE 3306

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD ["mysqld", "--user=mysql", "--datadir=/var/lib/mysql"]
