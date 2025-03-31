#!/bin/bash

# Vérifier si l'option --build est passée
BUILD=false
if [[ "$1" == "--build" ]]; then
  BUILD=true
fi

# Arrêter et supprimer les conteneurs existants
echo "Arrêt des conteneurs existants..."
docker-compose down

# Créer la base de données de test si elle n'existe pas
echo "Création de la base de données de test si nécessaire..."
docker-compose up -d mysql
sleep 5 # Attendre que MySQL démarre
docker exec -it $(docker ps -qf "name=javaangular-mysql") sh -c "mysql -u root -proot -e 'CREATE DATABASE IF NOT EXISTS testdb;'"

# Rebuild uniquement si nécessaire
if $BUILD; then
  echo "Reconstruction de l'image Docker..."
  docker-compose build tests
fi

# Démarrer le service de tests
echo "Démarrage des tests..."
docker-compose up tests
