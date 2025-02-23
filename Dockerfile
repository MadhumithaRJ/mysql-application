FROM openjdk:17-jdk-slim
WORKDIR /app
ENV PORT 6655
COPY target/my-sql-app.jar /app/my-sql-app.jar
EXPOSE 6655
ENTRYPOINT ["java", "-jar", "/app/my-sql-app.jar"]
