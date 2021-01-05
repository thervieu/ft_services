#!/bin/sh

adduser -D -h /var/ftp thervieu
echo "thervieu:password" | chpasswd

vsftpd /etc/vsftpd/vsftpd.conf