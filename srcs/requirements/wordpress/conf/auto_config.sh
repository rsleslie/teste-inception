#!/bin/bash

while ! mysqladmin -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h "mariadb" status; do
  echo "Servidor MariaDB não está acessível"
  sleep 10
done

echo "DATABASE CONECTED"

if ! wp core is-installed --path=/var/www/wordpress/ --allow-root; then

    echo "criando o config"
    wp config create --allow-root \
		--path=/var/www/wordpress \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost="mariadb"\

    wp core install \
        --allow-root \
        --path=/var/www/wordpress/ \
        --url="$DOMAIN_NAME" \
        --title="$MYSQL_TITLE" \
        --admin_user="$ADMIN_USER" \
        --admin_password="$ADMIN_PASSWORD" \
        --admin_email="$ADMIN_EMAIL" \
		--skip-email

    wp user create \
        "$MYSQL_USER" \
        "$USER_EMAIL" \
        --role=author \
        --user_pass=$MYSQL_PASSWORD \
        --path=/var/www/wordpress/ \
        --allow-root

	wp plugin update --all --allow-root --path=/var/www/wordpress

	chown -R www-data:www-data /var/www/wordpress
	chmod -R 775 /var/www/wordpress
fi

exec "$@"