FROM maven:3.8.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY .  .
RUN mvn package -DskipTests

FROM 17.0.4.1_1-jre-alpine
WORKDIR /run
COPY --from=builder /app/target/demo-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
CMD java  -jar /run/demo.jar
