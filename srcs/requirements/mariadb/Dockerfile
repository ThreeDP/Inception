# Linux Version
ARG IMAGE=alpine
ARG VERSION=3.17

# Linux Image
FROM ${IMAGE}:${VERSION}

# Update the apks and install mariadb
# Remove cache files of apks
RUN apk update
RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils && \
	rm -f /var/cache/apk/*

# Add config script in the container
ADD ./conf/start_mariadb.sh /scripts/start_mariadb.sh
RUN chmod -R 775 /scripts

# Expose port 3306 for the network
EXPOSE 3306

RUN echo "'$MYSQL_DATABASE' '$MYSQL_USER' '$MYSQL_PASSWORD'"

# Exec config script in the start of container
RUN chmod +x /scripts/start_mariadb.sh
ENTRYPOINT [ "ash", "/scripts/start_mariadb.sh" ]
