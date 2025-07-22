#!/bin/sh
set -e

# Variables d’environnement par défaut
DB_HOST=${DB_HOST:-mariadb}
DB_NAME=${MYSQL_DATABASE:-wordpress}
DB_USER=${MYSQL_USER:-wp_user}
DB_PASSWORD=$(cat /run/secrets/db_password)

# Installer WP si nécessaire
if [ ! -f wp-config.php ]; then
    echo "[INFO] Téléchargement de WordPress..."
    wp core download --allow-root

    echo "[INFO] Création du fichier wp-config.php..."
    wp config create --allow-root \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="$DB_HOST"

    echo "[INFO] Installation de WordPress..."
    wp core install --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception 42" \
        --admin_user="admin42" \
        --admin_password="$(cat /run/secrets/wp_admin_password)" \
        --admin_email="admin@${DOMAIN_NAME}.fr"

else
    echo "[INFO] WordPress déjà installé."
fi

exec php-fpm82 -F