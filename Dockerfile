# For a Jar, we will have two builds. One with JDK and Gradle itself for building the application
# and a final one with JRE only. This makes the final image lighter.
# Source: https://codefresh.io/docs/docs/learn-by-example/java/gradle/
# Source: https://spring.io/guides/topicals/spring-boot-docker/

############################
###         build        ###
############################
# Start from a gradle Docker image. We call this image "build"
# gradle:7.3.1-jdk11 is a Docker image with Gradle 7.3.1 and JDK 11 already
# installed. You can find other images here: https://hub.docker.com/_/gradle
FROM gradle:7.3.1-jdk11 AS build

# Copy source code (.) onto the image
COPY --chown=gradle:gradle . /home/gradle/src

# Move to the directory with the source code
WORKDIR /home/gradle/src

# Compile and run unit tests
RUN gradle build

############################
###         Run          ###
############################

# Use a JRE image this time
# Here we discard the Gradle image with all the compiled classes/unit test results etc.
FROM openjdk:11-jre-slim as XMas

# Make the port of the application available
EXPOSE 8080

# Create a directory for the app
RUN mkdir /xmas


VOLUME /tmp

# Copy only Jar files from the build image (from=build) onto the new image
# Copy all jars from gradle build directory then the application jar
COPY --from=build /home/gradle/src/build/libs/*.jar /app/xmas.jar

# The command that starts the application
ENTRYPOINT ["java", "-jar","/app/xmas.jar"]
