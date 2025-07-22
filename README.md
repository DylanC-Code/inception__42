# 🐳 Inception – Projet 42

## Description
Mise en place d’une infrastructure Docker sécurisée avec NGINX, WordPress et MariaDB, orchestrée via `docker-compose`.  
Chaque service tourne dans un container dédié avec TLS, volumes, réseau et variables d’environnement, en suivant les bonnes pratiques DevOps.

## Prérequis

- Une machine virtuelle Linux fonctionnelle (conseillé : Debian ou Alpine)
- Docker ≥ 20.x
- Docker Compose ≥ 1.29
- Accès `sudo`
- Port 443 disponible (HTTPS)

## Contenu du projet

- 🔐 NGINX avec TLSv1.2/1.3 en point d’entrée unique
- 🛢️ MariaDB pour la base de données WordPress
- ✍️ WordPress avec PHP-FPM
- 📁 Volumes pour la persistance des données
- 🧩 Réseau Docker dédié
- ⚙️ Makefile pour automatiser le build
- 🔒 Utilisation de `.env` et `Docker secrets`

---

## Structure de configuration

### 🔧 `.env` (dans `srcs/`)

Ce fichier définit certaines variables d’environnement utilisées à la création des services :
```env
DOMAIN_NAME=<domain>
MYSQL_DATABASE=<db_name>
MYSQL_USER=<user>
```

### 🔐 Secrets

Deux types de secrets sont utilisés :

- Dossier `srcs/secrets/` à la racine :
  - `db_password` → mot de passe de l'utilisateur `MYSQL_USER`
  - `ftp_password` → mot de passe de l'utilisateur `ftpuser`

- Dossier `srcs/mariadb/secrets/` :
  - `db_root_password` → mot de passe du compte `root` MariaDB

- Dossier `srcs/wordpress/secrets/` :
  - `wp_admin_password` → mot de passe du compte `root` WordPress

Ces secrets sont injectés automatiquement dans les conteneurs via la directive `secrets:` du `docker-compose.yml`.

---

## Bonus possibles

- Redis pour le cache WordPress
- Serveur FTP vers les fichiers du site
- Site statique (autre que PHP)
- Adminer pour la gestion de la DB
- Service libre supplémentaire justifié

## Sécurité & bonnes pratiques

- Aucun mot de passe en dur dans les Dockerfiles
- Utilisation de variables d’environnement et secrets
- Nom d’utilisateur admin personnalisé (sans “admin”)
- Interdiction d’utiliser `tail -f`, `sleep infinity`, `while true`...
- Tous les containers doivent redémarrer automatiquement

## Lancement

```bash
make up
```
Puis accédez au site via : `https://<login>.42.fr`

---

## Arborescence

```css
.
├── Makefile
├── srcs/
    ├── .env
    ├── docker-compose.yml
    ├── secrets/
    ├── nginx/
    ├── wordpress/
    └── mariadb/
        └── secrets/
            └── db_root_password
```

---

## Évaluation

- ✅ Partie obligatoire : doit être parfaite pour valider les bonus
- 🧠 Bonus évalués uniquement si aucun bug n’est détecté
- 📁 Le projet est évalué exclusivement à partir du contenu du dépôt Git