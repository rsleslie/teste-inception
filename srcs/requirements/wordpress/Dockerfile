FROM debian:bullseye

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install -y \
    procps \
    vim \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "listen = 0.0.0.0:9000" >> /etc/php/7.4/fpm/pool.d/www.conf && \
    echo "clear_env = no" >> /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php && \
    ln -s /usr/sbin/php-fpm7.4 /usr/bin/php-fpm

WORKDIR /var/www/wordpress/

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN wp core download --path=/var/www/wordpress/ --allow-root --version=5.8.2

COPY ./conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

EXPOSE 9000

STOPSIGNAL SIGQUIT

ENTRYPOINT [ "bash", "auto_config.sh" ]