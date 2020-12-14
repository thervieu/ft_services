FROM alpine:latest

MAINTAINER thervieu <thervieu@student.42.fr>

RUN	apk update && apk add nginx && apk add wget ; \
    apk add --no-cache php7 php7-fpm php7-opcache php7-common ; \
    apk add php7-gd php7-mysqli php7-zlib php7-curl ; \
	apk add php-json supervisor; \
	apk add --update cache ; \
	apk add php-bz2 ; \
	apk add --no-cache openrc openssl openssh

RUN apk add curl ; \
		apk add php-phar ; \
		apk add sudo ; \
		apk add php7-iconv ; \
		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar ; \
		chmod +x wp-cli.phar ; \
		sudo mv wp-cli.phar /usr/local/bin/wp ; \
		apk add mysql-client

RUN	mkdir -p var/run/nginx

COPY	nginx.conf /etc/nginx/nginx.conf

COPY /wp-config.php /www/wordpress/

COPY    start.sh .

RUN	chmod +x start.sh

COPY create.sh .

RUN chmod 777 create.sh

EXPOSE 5050

CMD	["sh", "./start.sh" ]