# Build java web using Maven
FROM maven:3.9.5-eclipse-temurin-17 AS build

WORKDIR /app

COPY . .

RUN mvn clean package

# stage 2: Deploy WAR file to tomcat
FROM tomcat:9.0.104-jdk8-temurin-jammy

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from= bruild /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh","run"]