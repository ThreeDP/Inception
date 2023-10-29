# Linux Version
ARG IMAGE=alpine:
ARG VERSION=3.16

# Linux Image
FROM ${IMAGE}:${VERSION}

RUN apk update &&		\
	apk add php8.0		\
	php8.0-fpm 			\
	php8.0-mysqli 		\
	mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN wp-cli.phar --info
RUN chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp


RUN mkdir -p /var/www/wordpress
ADD ./conf /var/www/wordpress
WORKDIR /var/www/wordpress

RUN wp core download --allow-root

EXPOSE 9000

RUN chmod +x start_wordpress.sh
ENTRYPOINT [ "bash", "start_wordpress.sh" ]