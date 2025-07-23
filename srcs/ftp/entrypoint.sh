#!/bin/sh

set -eu

# Create the FTP user with the password from the secret
FTP_PASSWORD=$(cat /run/secrets/ftp_password)
# useradd -m -d "/home/ftpuser" -s /sbin/nologin ftpuser && \
echo "ftpuser:$FTP_PASSWORD" | chpasswd

# Set the home directory permissions
# chown -R "ftpuser: "/home/ftpuser"

exec vsftpd /etc/vsftpd/vsftpd.conf
