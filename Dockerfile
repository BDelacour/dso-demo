FROM maven:3.8.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY .  .
RUN mvn package -DskipTests

FROM 17.0.4.1_1-jre-alpine
WORKDIR /run
COPY --from=builder /app/target/demo-0.0.1-SNAPSHOT.jar demo.jar

ARG USER=whoever
ENV HOME /home/$USER
RUN adduser -D $USER && \
    chown $USER:$USER /run/demo.jar

RUN apk add curl
HEALTHCHECK --interval=30s --timeout=10s --retries=2 --start-period=20s \
    CMD curl -f http://localhost:8080/ || exit 1

USER $USER

EXPOSE 8080
CMD java  -jar /run/demo.jar
