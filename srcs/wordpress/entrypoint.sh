#!/bin/sh
set -e

# Variables d’environnement par défaut
DOMAIN_NAME=${DOMAIN_NAME:-dcastor.42.fr}
DB_HOST=${DB_HOST:-mariadb}
DB_NAME=${MYSQL_DATABASE:-wordpress}
DB_USER=${MYSQL_USER:-wp_user}
DB_PASSWORD=$(cat /run/secrets/db_password)
ADMIN_USER=$(cat /run/secrets/wp_admin_user)
ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER=$(cat /run/secrets/wp_user)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

# Installer WP si nécessaire
if [ ! -f wp-config.php ]; then
    echo "[INFO] Téléchargement de WordPress..."
    wp core download --allow-root

    echo "[INFO] Création du fichier wp-config.php..."
    wp config create --allow-root \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="$DB_HOST" \
        --dbcharset="utf8" \
        --dbcollate=""

    echo "[INFO] Ajout des constantes personnalisées..."

    wp config set WP_HOME "https://${DOMAIN_NAME}" --type=constant --allow-root
    wp config set WP_SITEURL "https://${DOMAIN_NAME}" --type=constant --allow-root

    wp config set WP_REDIS_HOST "redis" --type=constant --allow-root
    wp config set WP_REDIS_PORT 6379 --type=constant --raw --allow-root
    wp config set WP_REDIS_TIMEOUT 1 --type=constant --raw --allow-root
    wp config set WP_REDIS_READ_TIMEOUT 1 --type=constant --raw --allow-root
    wp config set WP_REDIS_DISABLED false --type=constant --raw --allow-root
    wp config set WP_CACHE true --type=constant --raw --allow-root

    wp config set WP_DEBUG true --type=constant --raw --allow-root
    wp config set WP_DEBUG_LOG true --type=constant --raw --allow-root

#     echo "
# if (isset(\$_SERVER['HTTP_X_FORWARDED_PROTO']) && \$_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
#     \$_SERVER['HTTPS'] = 'on';
# }
# " >> wp-config.php

    echo "[INFO] Installation de WordPress..."
    wp core install --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception 42" \
        --admin_user="$ADMIN_USER" \
        --admin_password="$ADMIN_PASSWORD" \
        --admin_email="${ADMIN_USER}@${DOMAIN_NAME}.fr"

    wp user create ${WP_USER} ${WP_USER}@${DOMAIN_NAME}.fr --role=author --user_pass=${WP_USER_PASSWORD} --allow-root
else
    echo "[INFO] WordPress déjà installé."
fi

exec php-fpm82 -F
