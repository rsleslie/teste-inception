FROM debian:bullseye

RUN apt-get update && apt-get install -y apt-utils && apt-get install -y nginx

RUN apt-get install openssl -y

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=BR/ST=SP/L=SP/O=42/OU=rleslie-/CN=leslie.42.fr"

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

WORKDIR /etc/nginx

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]