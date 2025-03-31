#!/bin/bash

# Vérifier si la base de données 'mydb' existe, sinon la créer
echo "Vérification et création de la base de données 'mydb' si nécessaire..."
docker-compose up -d mysql
sleep 5 # Attendre que MySQL démarre
docker exec -it $(docker ps -qf "name=javaangular-mysql") sh -c "mysql -u root -proot -e 'CREATE DATABASE IF NOT EXISTS mydb;'"

# Démarrer le service Spring Boot
echo "Démarrage du service Spring Boot..."
docker-compose up springboot
# docker-compose up --build springboot