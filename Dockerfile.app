# Étape de build (avec Maven)
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app

# Copier le fichier pom.xml et le wrapper Maven
COPY pom.xml .
COPY mvnw .
COPY .mvn/ .mvn/

# Télécharger les dépendances Maven
RUN mvn dependency:go-offline -B

# Copier le code source et compiler l’application
COPY src/ src/
RUN mvn clean package -DskipTests

# Étape finale : exécution sur une image allégée avec OpenJDK
FROM openjdk:17-slim
WORKDIR /app

# Copier le JAR construit depuis l’étape build
COPY --from=build /app/target/*.jar app.jar

# Exposer le port sur lequel Spring Boot écoute (par défaut 8080)
EXPOSE 8080

# Lancer l’application
ENTRYPOINT ["java", "-jar", "app.jar"]