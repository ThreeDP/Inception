# Linux Version
ARG IMAGE=alpine
ARG VERSION=3.17

# Linux Image
FROM ${IMAGE}:${VERSION}

RUN apk update --no-cache && 	\
	apk add php81				\
	php81-cli					\
	php-fpm						\
	php81-phar					\
	php81-mysqli				\
	php81-curl					\
	php81-json					\
	php81-zip					\
	php81-gd					\
	php81-xml					\
	php81-mbstring				\
	php81-bcmath				\
	mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/wordpress
ADD ./conf/start_wordpress.sh /var/www/wordpress/start_wordpress.sh
WORKDIR /var/www/wordpress

RUN wp core download --allow-root --version=6.3

EXPOSE 9000
RUN echo "listen = 0.0.0.0:9000" >> /etc/php81/php-fpm.d/www.conf

RUN chmod +x start_wordpress.sh
ENTRYPOINT [ "ash", "-f", "start_wordpress.sh" ]