#!/bin/bash

set -e  # Quitte le script si une commande échoue

# Crée un dossier pour le projet docker WordPress + Zabbix
mkdir -p /opt/wp-zabbix

# Se déplace dans le dossier créé
cd /opt/wp-zabbix

# Crée le fichier docker-compose.yml avec la configuration
cat > docker-compose.yml <<EOF
version: "3.9"  # Version du format docker-compose

services:

  # ---------------------------
  # Base de données WordPress
  # ---------------------------
  wordpress_db:
    image: mariadb:10.6  # Image MariaDB 10.6 pour la base WordPress
    environment:
      MYSQL_ROOT_PASSWORD: rootpwd  # Mot de passe root de MariaDB
      MYSQL_DATABASE: wpdb          # Nom de la base WordPress
      MYSQL_USER: wpuser            # Utilisateur pour WordPress
      MYSQL_PASSWORD: wppass        # Mot de passe utilisateur
    volumes:
      - wordpress_db:/var/lib/mysql  # Persistance des données de la DB
    restart: always                  # Redémarrage automatique du conteneur

  # ---------------------------
  # WordPress
  # ---------------------------
  wordpress:
    image: wordpress:latest          # Dernière version de WordPress
    depends_on:
      - wordpress_db                 # Attend que la DB soit prête
    ports:
      - "8080:80"                    # Redirection du port externe 8080 vers 80
    environment:
      WORDPRESS_DB_HOST: wordpress_db # Nom du service DB
      WORDPRESS_DB_USER: wpuser       # Utilisateur DB
      WORDPRESS_DB_PASSWORD: wppass   # Mot de passe DB
      WORDPRESS_DB_NAME: wpdb         # Nom de la DB à utiliser
    volumes:
      - wordpress_data:/var/www/html  # Persistance des fichiers WordPress
    restart: always                    # Redémarrage automatique du conteneur

  # ---------------------------
  # Base de données Zabbix
  # ---------------------------
  zabbix_db:
    image: mariadb:10.6             # Base MariaDB pour Zabbix
    environment:
      MYSQL_ROOT_PASSWORD: rootpwd  # Mot de passe root
      MYSQL_DATABASE: zabbix        # Nom de la base Zabbix
      MYSQL_USER: zabbix            # Utilisateur Zabbix
      MYSQL_PASSWORD: zbxpass       # Mot de passe utilisateur
    volumes:
      - zabbix_db:/var/lib/mysql    # Persistance des données de la DB
    restart: always                  # Redémarrage automatique

  # ---------------------------
  # Serveur Zabbix
  # ---------------------------
  zabbix_server:
    image: zabbix/zabbix-server-mysql:latest  # Image officielle Zabbix serveur
    depends_on:
      - zabbix_db                  # Attend que la DB soit prête
    environment:
      DB_SERVER_HOST: zabbix_db    # Service de la DB
      MYSQL_DATABASE: zabbix       # Nom de la base Zabbix
      MYSQL_USER: zabbix           # Utilisateur Zabbix
      MYSQL_PASSWORD: zbxpass      # Mot de passe
    ports:
      - "10051:10051"              # Port du serveur Zabbix
    restart: always                # Redémarrage automatique

  # ---------------------------
  # Interface Web Zabbix
  # ---------------------------
  zabbix_web:
    image: zabbix/zabbix-web-apache-mysql:latest  # Interface web officielle
    depends_on:
      - zabbix_server              # Attend le serveur Zabbix
      - zabbix_db                  # Attend la DB
    environment:
      DB_SERVER_HOST: zabbix_db    # Service DB
      MYSQL_DATABASE: zabbix       # Nom de la base
      MYSQL_USER: zabbix           # Utilisateur
      MYSQL_PASSWORD: zbxpass      # Mot de passe
      ZBX_SERVER_HOST: zabbix_server  # Serveur Zabbix à connecter
    ports:
      - "8081:8080"                # Port externe 8081 vers interne 8080
    restart: always                # Redémarrage automatique

# ---------------------------
# Volumes persistants pour sauvegarder les données
# ---------------------------
volumes:
  wordpress_db:     # Volume pour la DB WordPress
  wordpress_data:   # Volume pour les fichiers WordPress
  zabbix_db:        # Volume pour la DB Zabbix
EOF

# Lancement des services en arrière-plan
docker compose up -d  # Démarre tous les conteneurs définis dans docker-compose.yml
