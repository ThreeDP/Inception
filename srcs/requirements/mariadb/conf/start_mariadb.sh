#!/bin/bash

# start mariadb service
systemctl start mariadb
# Check if the MariaDB service started successfully
if  systemctl is-active --quiet mariadb; then
	if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
		echo "\e[0;91m" " [ Database already exists ] " "\e[0m"
	else
		# Create Database
		mariadb -u $MYSQL_ROOT -p $MYSQL_ROOT_PASSWORD \
			-e "CREATE DATABASE $MYSQL_DATABASE;"

		# Create a user
		mariadb -u $MYSQL_ROOT -p $MYSQL_ROOT_PASSWORD \
			-e "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY 'MYSQL_PASSWORD';"

		# Give privileges for USER created
		mariadb -u $MYSQL_ROOT -p $MYSQL_ROOT_PASSWORD \
			-e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'localhost'"
	fi
else
	echo "\e[0;91m" " [ MariaDB service failed to start ] " "\e[0m"
fi