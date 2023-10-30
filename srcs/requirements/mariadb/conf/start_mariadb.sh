#!/bin/sh

#mariadb-install-db --user=mysql --datadir=/var/lib/mysql
#mariadbd-safe &

rc-service mariadb start

sleep 4; sleep 2
	
# Create Database
mariadb -e "CREATE DATABASE $MYSQL_DATABASE;"
mariadb -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY 'MYSQL_PASSWORD';"
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mariadb -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;"
mariadb -e "SELECT user, host FROM mysql.user;"
mariadb -e "SHOW DATABASES;"

