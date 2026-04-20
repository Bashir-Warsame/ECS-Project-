FastAPI URL Shortener on AWS ECS (Terraform)

A production-style DevOps project deploying a Dockerised FastAPI application to AWS ECS Fargate using Terraform.

Overview

This project provisions AWS infrastructure and deploys a containerised FastAPI app behind an Application Load Balancer.

# ECS FastAPI Infrastructure Project

Production-style deployment of a FastAPI application on AWS using Terraform, ECS Fargate, Application Load Balancer, Route53, and ACM.

---

## 🚀 Overview

This project provisions cloud infrastructure and deploys a containerized FastAPI app with:

* **Terraform** for Infrastructure as Code
* **AWS ECS Fargate** for serverless containers
* **Application Load Balancer (ALB)** for traffic routing
* **Amazon ECR** for Docker image storage
* **Route53** for custom domain DNS
* **AWS ACM** for HTTPS / SSL certificates
* **GitHub Actions + OIDC** planned for CI/CD

---

## 🏗 Architecture

```text
User
 ↓
Route53
 ↓
HTTPS (ACM)
 ↓
Application Load Balancer
 ↓
ECS Fargate Service
 ↓
FastAPI Container
```

---

## 📦 Infrastructure Components

### Networking

* Custom VPC
* Public subnets
* Private subnets
* Internet Gateway
* Security Groups

### Compute

* ECS Cluster
* ECS Service
* Fargate Tasks
* Task Definition

### Load Balancing

* ALB
* Target Group
* Health Checks
* HTTP → HTTPS redirect

### DNS / Security

* Route53 Hosted Zone
* Domain records
* ACM certificate with DNS validation

---

## 🌐 Live Endpoints

* `https://bashirwarsame.online`
* `https://api.bashirwarsame.online`

---

## 🛠 Tech Stack

* Python / FastAPI
* Docker
* Terraform
* AWS ECS
* AWS ALB
* AWS Route53
* AWS ACM
* GitHub Actions

---

## 📁 Project Structure

```text
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules/
    ├── vpc/
    ├── alb/
    ├── ecs/
    ├── dns/
    └── acm/
```

---

## ▶️ Usage

### Initialize Terraform

```bash
terraform init
```

### Preview Changes

```bash
terraform plan
```

### Deploy Infrastructure

```bash
terraform apply
```

### Destroy Infrastructure

```bash
terraform destroy
```

---

## 🐳 Deploy App Image

Build and push Docker image to ECR:

```bash
docker build -t fastapi-app .
docker tag fastapi-app:latest <ecr-uri>:latest
docker push <ecr-uri>:latest
```

Redeploy ECS service:

```bash
aws ecs update-service \
  --cluster fastapi-ecs-cluster \
  --service fastapi-ecs-service \
  --force-new-deployment
```

---

## 🔐 Security

* HTTPS enabled with ACM
* ALB security groups
* ECS task security groups
* OIDC-based GitHub Actions deployment planned
* No hardcoded cloud credentials recommended

---

## 📈 Future Improvements

* GitHub Actions CI/CD with OIDC
* Blue/Green deployments with CodeDeploy
* ECS in private subnets + NAT Gateway
* CloudWatch dashboards and alarms
* VPC Endpoints
* Auto scaling policies

---

## 🎯 Purpose

This project demonstrates real-world AWS cloud engineering skills:

* Infrastructure as Code
* Container orchestration
* Secure networking
* DNS + TLS setup
* Production deployment patterns
* CI/CD foundations

