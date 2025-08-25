#!/bin/sh
set -eu

# Lire les secrets (s'ils existent)
if [ -f /run/secrets/db_root_password ]; then
    MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
fi
if [ -f /run/secrets/db_password ]; then
    MYSQL_USER_PASSWORD=$(cat /run/secrets/db_password)
fi

echo "[INFO] Mot de passe root DB = ${MYSQL_ROOT_PASSWORD}"
echo "[INFO] Mot de passe utilisateur DB = ${MYSQL_USER_PASSWORD}"

# Variables par défaut (avec fallback)
DB_NAME="${MYSQL_DATABASE:-wordpress}"
DB_USER="${MYSQL_USER:-wp_user}"
DB_DIR="/var/lib/mysql"

echo "[INFO] Utilisateur DB = ${DB_USER}"
echo "[INFO] Base de données = ${DB_NAME}"

# Vérifie si MariaDB est déjà initialisé
if [ ! -d "$DB_DIR/mysql" ]; then
    echo "[INFO] Initialisation de MariaDB..."

    mysql_install_db --user=mysql --basedir=/usr --datadir="$DB_DIR"

    mysqld --user=mysql --bootstrap <<EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE OR REPLACE USER '${DB_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
CREATE OR REPLACE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
CREATE OR REPLACE USER '${DB_USER}'@'127.0.0.1' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'localhost';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'127.0.0.1';
FLUSH PRIVILEGES;
EOF

    echo "[INFO] Initialisation terminée."
else
    echo "[INFO] MariaDB déjà initialisée, on saute l'init."
fi

# Lancer MariaDB normalement
exec mysqld --user=mysql --datadir="$DB_DIR"
