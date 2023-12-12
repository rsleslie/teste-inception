FROM alpine:3.17

RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils && \
    rm -f /var/cache/apk/*

RUN mkdir -p /run/mysqld && \
    chown mysql:mysql /run/mysqld/ && \
    chmod 770 /run/mysqld/

ADD ./scripts/setup_db.sh .
RUN chmod +x ./setup_db.sh

EXPOSE 3306

ENTRYPOINT [ "ash", "setup_db.sh" ]
