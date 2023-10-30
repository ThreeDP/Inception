# Linux Version
ARG IMAGE=alpine
ARG VERSION=3.17

# Linux Image
FROM ${IMAGE}:${VERSION}

RUN mkdir -p /var/lib/mysql /var/run/mysqld && chmod -R 777 /var/run/mysqld

# Update the apks and install mariadb
RUN apk update && \
	apk add --no-cache mariadb mariadb-client openrc
	RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

ARG MYSQL_DATABASE
ARG MYSQL_ROOT
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG HOST_NAME

COPY ./conf/start_mariadb.sh /etc/mysql/start_mariadb.sh
WORKDIR /etc/mysql
#RUN chmod a+x start_mariadb.sh; ash -f start_mariadb.sh

EXPOSE 3306

ENTRYPOINT [ "tail", "-f", "/dev/null" ]
#ENTRYPOINT [ "mariadbd-safe" ]
