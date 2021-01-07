FROM alpine:latest

RUN apk upgrade
RUN apk add openssl vsftpd
RUN apk add jq curl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=PARIS/O=42/CN=thervieu' -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

RUN mkdir -p /var/ftp
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY start.sh /tmp/
RUN chmod 777 /tmp/start.sh

EXPOSE 20 21 21021

ENTRYPOINT ["/tmp/start.sh"]
