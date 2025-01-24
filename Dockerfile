FROM maven:3.9.9-amazoncorretto-23 AS build

WORKDIR /app

COPY pom.xml ./pom.xml
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn package

FROM openjdk:23-slim-bullseye

WORKDIR /app

COPY --from=build /app/target/eureka-server*.jar ./app.jar

CMD ["java", "-jar", "app.jar"]