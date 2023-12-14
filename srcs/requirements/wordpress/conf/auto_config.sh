#!/bin/bash

while ! mysqladmin -u "$WP_DB_USER" -p"$WP_DB_PASSWORD" -h "mariadb" status; do
  sleep 10
done

echo "DATABASE CONECTED"

if ! wp core is-installed --path=/var/www/wordpress/ --allow-root; then

    echo "creating the config..."
    wp config create --allow-root \
        --path=/var/www/wordpress \
        --dbname=$WP_DATABASE \
        --dbuser=$WP_DB_USER \
        --dbpass=$WP_DB_PASSWORD \
        --dbhost=$WP_DATABASE_HOST\

    wp core install \
        --allow-root \
        --path=/var/www/wordpress/ \
        --url="rleslie.42.fr" \
        --title="Inception Project 42" \
        --admin_user="$WP_ROOT" \
        --admin_password="$WP_ROOT_PASSWORD" \
        --admin_email="$WP_ROOT@student.42sp.org.br" \

    wp user create \
        $WP_USER \
        $WP_USER@student.42sp.org.br \
        --user_pass=$WP_PASSWORD \
        --path=/var/www/wordpress/ \

    wp plugin update --all --allow-root --path=/var/www/wordpress

    chown -R www-data:www-data /var/www/wordpress
    chmod -R 775 /var/www/wordpress
fi

php-fpm7.4 -F -R