FROM maven:3.5.4-jdk-11

COPY . /app/

WORKDIR /app

CMD ["mvn", "spring-boot:run", "-Dspring-boot.run.profiles=test"]

EXPOSE 8080