# Use an official OpenJDK runtime as a parent image
FROM openjdk:18-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container at /app
COPY target/newbee-mall-api-3.0.0-SNAPSHOT.jar /app/app.jar

# Expose the port your application runs on
EXPOSE 8000

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
