FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src
COPY mvnw .

RUN mvn install

FROM openjdk:11-jre-slim

VOLUME /tmp
WORKDIR /app

COPY --from=build /app/target/Uber.jar .
EXPOSE 9090
CMD [ "java","-jar","Uber.jar" ]