#!/bin/sh

if [ -d "/run/mysqld" ]; then
	echo "mysqld exist"
	chown -R mysql:mysql /run/mysqld
else
	echo "mysqld not found, creating ..."
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then	
	echo "Mariadb directory exist"
	chown -R mysql:mysql /var/lib/mysql
else
	echo "Mariadb directory not found, creating..."
	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --user=mysql --ldata=/var/lib/mysql

	echo "Creating database: $MYSQL_DATABASE"
	mariadbd-safe &
	sleep 4; sleep 2
	mariadb -e "FLUSH PRIVILEGES"
	mariadb -e "SET PASSWORD FOR 'root'@'localhost'=PASSWORD('$MYSQL_ROOT_PASSWORD');"
	mariadb -e "DROP DATABASE IF EXISTS test;"
	mariadb -e "FLUSH PRIVILEGES"
	mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;"
	mariadb -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mariadb -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mariadb -e "GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;"
	mariadb -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES"
fi

/usr/bin/mysqld --user=mysql --verbose=0 --skip-networking=0
