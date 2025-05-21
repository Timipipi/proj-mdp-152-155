# Stage 1: Build the app using Maven
FROM maven:3.8.5-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the app using Tomcat
FROM tomcat:9.0
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/calculator.war
EXPOSE 8080
CMD ["catalina.sh", "run"]


