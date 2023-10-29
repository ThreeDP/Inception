# Linux Version
ARG IMAGE=alpine:
ARG VERSION=3.16

# Linux Image
FROM ${IMAGE}:${VERSION}

# Update the apks and install mariadb
RUN apk update && \
	apk add mariadb-server -y

ARG MYSQL_DATABASE
ARG MYSQL_ROOT
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_USER
ARG MYSQL_PASSWORD

ADD ./conf/ /etc/mysql
WORKDIR /etc/mysql
RUN bash start_mariadb.sh

EXPOSE 3306

ENTRYPOINT [ "mysql", "--bind-address=0.0.0.0" ]