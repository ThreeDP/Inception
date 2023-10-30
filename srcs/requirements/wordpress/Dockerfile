# Linux Version
ARG IMAGE=alpine
ARG VERSION=3.16

# Linux Image
FROM ${IMAGE}:${VERSION}

RUN apk update &&			\
	apk add php8			\
	php8-fpm 				\
	php8-mysqli 			\
	php8-pdo				\
	php8-pdo_mysql			\
	php8-phar				\
	mysql-client --no-cache

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/wordpress
COPY ./conf/start_wordpress.sh /var/www/wordpress/start_wordpress.sh
WORKDIR /var/www/wordpress

RUN wp core download --allow-root

EXPOSE 9000
RUN echo "listen = 0.0.0.0:9000" >> /etc/php8/php-fpm.d/www.conf

RUN chmod +x start_wordpress.sh
ENTRYPOINT [ "ash", "-f", "start_wordpress.sh" ]
