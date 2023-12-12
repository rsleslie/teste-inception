#!/bin/sh

if [ -d "/run/mysqld" ]; then
    chown -R mysql:mysql /run/mysqld
else
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

# if [ id "/var/lib/mysql" ]; then
#     chown -R mysql:mysql /var/lib/mysql
# fi

chown -R mysql:mysql /var/lib/mysql
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>$MYSQL_USER<<<<<<<<<<<<<<<<<<<<"
if [ ! -d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql

    mysql_install_db --user=mysql --ldata=/var/lib/mysql
     
    mariadbd-safe &
    sleep 4; sleep 2

    mysql -e "FLUSH PRIVILEGES"
	mysql -e "SET PASSWORD FOR 'root'@'localhost'=PASSWORD('$MYSQL_ROOT_PASSWORD');"
	mysql -e "DROP DATABASE IF EXISTS test;"
	mysql -e "FLUSH PRIVILEGES"
	mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;"
	mysql -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mysql -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mysql -e "GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;"
	mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES"
else
    echo "Inception database is already created"
fi


/usr/bin/mysqld --user=mysql
