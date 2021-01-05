FROM alpine:latest

MAINTAINER thervieu <thervieu@student.42.fr>

RUN	apk update && apk add nginx ; \
	apk add --no-cache openrc openssl openssh

RUN	mkdir -p var/run/nginx

COPY	index.html /www/

COPY	nginx.conf /etc/nginx/nginx.conf

RUN	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/example.key -out /etc/nginx/example.crt -subj "/C=FR/ST=IDE/L=Paris/O=42/OU=42/CN=osef.com" 

EXPOSE	80 443

CMD	nginx -g "daemon off;"