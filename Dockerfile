# Use maven to compile the java application.
FROM maven:3-jdk-11-slim AS build-env
# Set the working directory to /app
WORKDIR /app

# copy the pom.xml file to download dependencies
COPY pom.xml ./

# download dependencies as specified in pom.xml
# building dependency layer early will speed up compile time when pom is unchanged
RUN mvn verify --fail-never

# Copy the rest of the working directory contents into the container
COPY . ./

# Compile the application.
RUN mvn -Dmaven.test.skip=true package

# Build runtime image.
#FROM gcr.io/distroless/java11-debian11
FROM openjdk:19-slim-bullseye
#FROM openjdk:18.0-jdk
ENV UID=1100
ENV GID=1100
ENV UNAME=user
RUN groupadd -g $GID -o $UNAME 
RUN useradd -m -l -u $UID -g $GID -o -s /bin/bash $UNAME
USER ${UID}:${GID}
# Copy the compiled files over.
COPY --from=build-env /app/target/ /app/
EXPOSE 80
# Starts java app with debugging server at port 5005.
CMD ["java", "-jar", "/app/hello-world-1.0.2.jar"]
