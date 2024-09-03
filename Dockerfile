FROM openjdk:11-jre-slim
WORKDIR /app
COPY target/SimpleWebApp-4.0-SNAPSHOT.jar /app/SimpleWebApp-4.0-SNAPSHOT.jar
EXPOSE 3000
ENTRYPOINT ["java"]
CMD ["-jar","SimpleWebApp-4.0-SNAPSHOT.jar"]
