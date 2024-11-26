# **Movie Ticket Booking Platform**

## **Overview**
The Movie Ticket Booking Platform is a scalable microservices-based application designed for booking movie tickets. The architecture is optimized for deployment on AWS using modern cloud-native technologies and best practices.

---

## **Features**
1. **Microservices Architecture**: Modular and scalable design.
2. **Cloud-Native**: Optimized for AWS services like EKS, Fargate, Aurora, ElastiCache, and MSK.
3. **User Authentication**: Secure user authentication using Spring Security and OAuth2.
4. **Database Management**: Powered by Amazon Aurora (PostgreSQL) with Flyway for schema migrations.
5. **Event-Driven Communication**: Asynchronous messaging with Amazon MSK (Kafka).
6. **Notification Service**: Booking confirmations sent via Amazon SNS and SES.
7. **Analytics**: Data pipelines for insights using AWS Glue and Amazon Athena.
8. **CI/CD**: Dockerized deployments with Google Jib and container orchestration using Kubernetes.

---

## **Tech Stack**
### **Backend**
- **Java 17** with **Spring Boot**
- **Spring Data JPA** for ORM
- **Spring Security** for authentication and authorization
- **Flyway** for database migrations
- **AWS SDK** for integrating with AWS services

### **Database**
- **Amazon Aurora (PostgreSQL)** for relational data
- **Amazon DynamoDB** for key-value storage
- **Amazon ElastiCache (Redis)** for caching

### **Messaging**
- **Apache Kafka** (via Amazon MSK) for asynchronous communication

### **Deployment**
- **Google Jib** for containerization
- **AWS EKS** and **Fargate** for container orchestration
- **AWS CloudFront** for content delivery
- **AWS S3** for static asset storage

### **Monitoring & Logging**
- **Prometheus** and **Grafana** for metrics
- **AWS CloudWatch** and **X-Ray** for logging and distributed tracing

---

## **Project Structure**
```plaintext
movie-ticket-platform/
├── settings.gradle              # Gradle settings file
├── gradle.properties            # Shared properties for all modules
├── build.gradle                 # Root Gradle build configuration
├── user-service/                # Microservice for user management
│   ├── src/main/                # Application source code
│   └── src/test/                # Test source code
├── theatre-service/             # Microservice for managing theatres
├── booking-service/             # Microservice for booking tickets
├── payment-service/             # Microservice for payment processing
├── notification-service/        # Microservice for sending notifications
├── analytics-service/           # Microservice for analytics
└── admin-service/               # Microservice for admin functionalities
```

---

## **Getting Started**

### **Prerequisites**
- **Java 17**
- **Gradle**
- **Docker**
- **AWS CLI** (configured with proper credentials)

### **Local Development**
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-repo/movie-ticket-platform.git
   cd movie-ticket-platform
   ```

2. **Build the Project**:
   ```bash
   ./gradlew build
   ```

3. **Run a Service Locally**:
   Navigate to a microservice directory (e.g., `user-service`) and start the service:
   ```bash
   ./gradlew bootRun
   ```

---

## **Deployment**
### **Build Docker Images**
Build Docker images for all microservices using **Google Jib**:
```bash
./gradlew :user-service:jib
```

### **Push to AWS ECR**
Ensure AWS CLI is configured and the ECR repository exists:
```bash
./gradlew :user-service:jib --image=public.ecr.aws/your-repo/user-service:latest
```

### **Deploy to AWS EKS**
Use your preferred Kubernetes deployment tool (e.g., kubectl, Helm) to deploy services to EKS:
```bash
kubectl apply -f deployment.yaml
```

---

## **Database Configuration**
This project uses **Flyway** for managing database migrations.

1. Place migration scripts in the directory:
   ```plaintext
   src/main/resources/db/migration
   ```

2. Example Migration Script:
   ```sql
   CREATE TABLE users (
       id SERIAL PRIMARY KEY,
       username VARCHAR(50) NOT NULL,
       email VARCHAR(100) NOT NULL UNIQUE,
       password VARCHAR(255) NOT NULL
   );
   ```

3. Flyway automatically applies migrations on service startup.

---

## **Environment Variables**
| Variable           | Description                           | Example                           |
|--------------------|---------------------------------------|-----------------------------------|
| `SPRING_PROFILES_ACTIVE` | Spring Boot profile                | `prod`                            |
| `DB_HOST`          | Database host                        | `aurora-instance.amazonaws.com`   |
| `DB_PORT`          | Database port                        | `5432`                            |
| `DB_NAME`          | Database name                        | `movieplatform`                   |
| `DB_USER`          | Database username                    | `dbuser`                          |
| `DB_PASSWORD`      | Database password                    | `dbpassword`                      |

---

## **Testing**
Run all tests:
```bash
./gradlew test
```

---

## **Contributing**
1. Fork the repository.
2. Create a feature branch: `git checkout -b feature-name`.
3. Commit your changes: `git commit -m "Add new feature"`.
4. Push to the branch: `git push origin feature-name`.
5. Open a pull request.

---

## **License**
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## **Contact**
For questions or support, contact **[mdave.5191@gmail.com](mailto:mdave.5191@gmail.com)**.
