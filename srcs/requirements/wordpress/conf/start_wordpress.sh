#!/bin/bash

USER_MAIL=$MYSQL_USER@student.42sp.org.br

if [ ! -f ./wp-config.ph ]; then
	wp config create --allow-root 						\
		--dbname=$MYSQL_DATABASE						\
		--dbuser=$MYSQL_USER							\
		--dbpass=$MYSQL_PASSWORD						\
		--dbhost=$HOST_NAME								\
		--dbprefix='wp_'								

	wp core install --allow-root
		--url=https://$DOMAIN_NAME						\
		--title="Ohhhh God Dawn"						\
		--admin_user=$MYSQL_USER						\
		--admin_password=$MYSQL_PASSWORD				\
		--admin_email=$USER_MAIL

	wp user create --allow-root 
		$MYSQL_USER										\
		$USER_MAIL 										\
		--user_pass=$MYSQL_PASSWORD;
fi

php-fpm8 -R