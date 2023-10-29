# Linux Version
ARG IMAGE=alpine:
ARG VERSION=3.16

# Linux Image
FROM ${IMAGE}:${VERSION}
RUN apk update && 				\
	apk add nginx 				\
				openssl

RUN mkdir -p /etc/nginx/self-signed-certs
WORKDIR /etc/nginx/self-signed-certs
RUN if [ ! -f certificate.pem ]; then \
    openssl req \
    -x509 \
    -newkey \
    rsa:4096 \
    -sha256 \
    -days 365 \
    -nodes \
    -keyout certificate.pem \
    -out certificate.pem.pub \
fi

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]