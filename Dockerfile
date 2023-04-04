FROM openjdk:8-jdk-alpine
COPY target/*.jar *.jar
ENTRYPOINT ["java","-jar","/vulnado-0.0.1-SNAPSHOT.jar"]
