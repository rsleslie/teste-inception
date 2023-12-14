FROM debian:bullseye

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install -y \
	procps \
	vim \
	php-fpm \
	php-mysql \
	mariadb-client \
	wget \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "\nlisten = 0.0.0.0:9000" >> /etc/php/7.4/fpm/pool.d/www.conf && \
	echo "clear_env = no" >>/etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php \
	&& ln -s /usr/sbin/php-fpm7.4 /usr/bin/php-fpm

WORKDIR /var/www/wordpress/

RUN wget \
	https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN wp core download --path=/var/www/wordpress/ --allow-root --version=6.3.2

# RUN cp wp-config-sample.php wp-config.php

COPY ./conf/auto_config.sh .
RUN chmod +x auto_config.sh \
	&& mv auto_config.sh /usr/bin/

EXPOSE 9000

STOPSIGNAL SIGQUIT

ENTRYPOINT [ "auto_config.sh" ]
CMD ["php-fpm", "-F"]