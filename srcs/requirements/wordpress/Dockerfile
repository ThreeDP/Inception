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
	mariadb-client --no-cache

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/wordpress
ADD ./conf /var/www/wordpress
WORKDIR /var/www/wordpress

RUN wp core download --allow-root

EXPOSE 9000

RUN chmod +x start_wordpress.sh
ENTRYPOINT [ "bash", "start_wordpress.sh" ]