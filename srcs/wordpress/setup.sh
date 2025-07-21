#!/bin/sh

if [ ! -f /var/www/wp-config.php ]; then
  cp wp-config-sample.php wp-config.php
  sed -i "s/database_name_here/${MARIADB_DATABASE}/" wp-config.php
  sed -i "s/username_here/${MARIADB_USER}/" wp-config.php
  sed -i "s/password_here/${MARIADB_PASSWORD}/" wp-config.php
  sed -i "s/localhost/${MARIADB_HOST}/" wp-config.php
fi