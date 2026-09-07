#!/bin/bash
# Script de sauvegarde du serveur Web Linux

BACKUP_DIR="/var/backups/web"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

# Archiver le dossier du site web et la configuration Nginx
tar -czf $BACKUP_DIR/web_backup_$DATE.tar.gz /var/www/html /etc/nginx

# Conserver uniquement les sauvegardes de moins de 7 jours
find $BACKUP_DIR -type f -mtime +7 -delete