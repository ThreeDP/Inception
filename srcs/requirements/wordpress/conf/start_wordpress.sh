#!/bin/sh

while ! mysql -u "$WP_DB_USER" -p"$WP_DB_PASSWORD" -h "$WP_DATABASE_HOST" -e "SHOW STATUS;"; do
	sleep 10
done

if [ ! -f ./wp-config.php ]; then
	echo "$WP_ROOT $WP_ROOT_PASSWORD"
	wp config create --allow-root 						\
		--path=/var/www/wordpress						\
		--dbname=$WP_DATABASE							\
		--dbuser=$WP_DB_USER							\
		--dbpass=$WP_DB_PASSWORD						\
		--dbhost=$WP_DATABASE_HOST						\
		--dbprefix='wp_'								\
		--dbcollate='utf8_general_ci'					\
		--dbcharset='utf8'	

	wp core install --allow-root						\
		--path=/var/www/wordpress						\
		--url=dapaulin.42.fr							\
		--title="Ohhhh God Dawn"						\
		--admin_user=$WP_ROOT							\
		--admin_password=$WP_ROOT_PASSWORD				\
		--admin_email=$WP_ROOT@student.42sp.org.br

	wp user create --allow-root 						\
		--path=/var/www/wordpress						\
		$WP_USER										\
		$WP_USER@student.42sp.org.br 					\
		--user_pass=$WP_PASSWORD
fi

php-fpm81 -F -R
