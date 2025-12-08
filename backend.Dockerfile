FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app

COPY backend/pom.xml ./pom.xml

RUN mvn dependency:go-offline -B

COPY backend/ ./

RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar ./app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]