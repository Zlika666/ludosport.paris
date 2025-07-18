#!/bin/bash

# Vérifie que l'utilisateur a fourni un paramètre
if [ -z "$1" ]; then
  echo "Usage : $0 <répertoire de la distribution>"
  exit 1
fi

# Teste si le répertoire existe
if [ -d "$1/web" ]; then
  cd $1/web
  chown -R 1001:1 .
  find . -type d -exec chmod u=rwx,g=rx,o= '{}' \;
  find . -type f -exec chmod u=rw,g=r,o= '{}' \;
  cd $1/web/sites
  find . -type d -name files -exec chmod ug=rwx,o= '{}' \;
  find ./*/files -type d -exec chmod ug=rwx,o= '{}' \;
  find ./*/files -type f -exec chmod ug=rw,o= '{}' \;
  echo "✅ Drupal file permissions successfully updated."
else
  echo "❌ Le répertoire '$1/web' n'existe pas."
  exit 2
fi