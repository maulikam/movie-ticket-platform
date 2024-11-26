#!/bin/bash

 MONOREPO_DIR="movie-ticket-platform"
MICROSERVICES=("user-service" "theatre-service" "booking-service" "payment-service" "notification-service" "admin-service" "analytics-service")

 echo "Creating monorepo directory structure..."
mkdir -p "$MONOREPO_DIR"
cd "$MONOREPO_DIR" || exit

 create_settings_gradle() {
    echo "Creating settings.gradle file..."
    cat <<EOL >settings.gradle
rootProject.name = 'movie-ticket-platform'
EOL
    for SERVICE in "${MICROSERVICES[@]}"; do
        echo "include('$SERVICE')" >>settings.gradle
    done
}

 create_gradle_properties() {
    echo "Creating gradle.properties file..."
    cat <<EOL >gradle.properties
org.gradle.jvmargs=-Xmx1024m -Dfile.encoding=UTF-8
version=0.0.1-SNAPSHOT
EOL
}

 create_root_build_gradle() {
    echo "Creating root build.gradle file..."
    cat <<EOL >build.gradle
plugins {
    id 'org.springframework.boot' version '3.4.0' apply false
    id 'io.spring.dependency-management' version '1.1.6' apply false
    id 'java' apply false
}

allprojects {
    group = 'com.publicissapient.movie'
    version = '0.0.1-SNAPSHOT'

    repositories {
        mavenCentral()
    }
}
EOL
}

 create_microservice() {
    SERVICE_NAME=$1
    SERVICE_DIR="$SERVICE_NAME/src/main/java/com/publicissapient/movie/$SERVICE_NAME"
    TEST_DIR="$SERVICE_NAME/src/test/java/com/publicissapient/movie/$SERVICE_NAME"
    mkdir -p "$SERVICE_DIR" "$TEST_DIR"

    echo "Creating build.gradle for $SERVICE_NAME..."
    cat <<EOL >"$SERVICE_NAME/build.gradle"
plugins {
    id 'java'
    id 'org.springframework.boot'
    id 'io.spring.dependency-management'
}

group = 'com.publicissapient.movie.$SERVICE_NAME'
version = '0.0.1-SNAPSHOT'

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(17)
    }
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'com.fasterxml.jackson.core:jackson-databind:2.15.0'
    implementation 'org.springframework.kafka:spring-kafka:3.0.0'
    implementation 'org.springframework.boot:spring-boot-starter-cache'

    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testRuntimeOnly 'org.junit.platform:junit-platform-launcher'
}

tasks.named('test') {
    useJUnitPlatform()
}
EOL
}

 create_settings_gradle
create_gradle_properties
create_root_build_gradle

 for SERVICE in "${MICROSERVICES[@]}"; do
    create_microservice "$SERVICE"
done

echo "Monorepo structure created successfully."
