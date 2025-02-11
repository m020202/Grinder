FROM openjdk:17-jdk-slim
WORKDIR /app
COPY ./build/libs/*SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=prod", "app.jar"]