#!/bin/sh

rc-service mariadb start

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
	echo "\e[0;91m" " [ Database already exists ] " "\e[0m"
else
	mariadb -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;"
	
	# Create Database
	mysqld -u $MYSQL_ROOT -p $MYSQL_ROOT_PASSWORD \
		-e "CREATE DATABASE $MYSQL_DATABASE;"

	# Create a user
	mysqld -u $MYSQL_ROOT -p $MYSQL_ROOT_PASSWORD \
		-e "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY 'MYSQL_PASSWORD';"

	# Give privileges for USER created
	mysqld -u $MYSQL_ROOT -p $MYSQL_ROOT_PASSWORD \
		-e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'localhost';"


	mysqld -u $MYSQL_ROOT -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
fi
