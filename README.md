# FastAPI URL Shortener on AWS ECS (Terraform)

A production-style DevOps project deploying a Dockerised FastAPI application to AWS ECS Fargate using Terraform.
This project provisions AWS infrastructure and deploys a containerised FastAPI app behind an Application Load Balancer.

##  Overview

This project provisions cloud infrastructure and deploys a containerized FastAPI app with:

* **Terraform** for Infrastructure as Code
* **AWS ECS Fargate** for serverless containers
* **Application Load Balancer (ALB)** for traffic routing
* **Amazon ECR** for Docker image storage
* **Route53** for custom domain DNS
* **AWS ACM** for HTTPS / SSL certificates
* **GitHub Actions + OIDC** planned for CI/CD
* **S3 + DynamoDB - Remote** state + locking
* **AWS Secrets Manager** – Secure secrets storage


---

##  Architecture

![Alt text](/images/aws-diagram.png)


##  Deployment
### Live Application
![Alt text](/images/live-app.png)
### Terraform Plan
![Alt text](/images/Terraform-plan.png)
### Terraform Apply
![Alt text](/images/Terraform-apply.png)
### Terraform Destroy
![Alt text](/images/Terraform-destroy.png)
### ECR Deployment
![Alt text](/images/Deploy-ECR.png)


## Live Endpoints

* `https://bashirwarsame.online`
* `https://api.bashirwarsame.online`

---

# Key Features

### Infrastructure as Code
Terraform is used to provision and manage all AWS resources in a repeatable, version-controlled way.
### Containerised Application
The FastAPI application is packaged using Docker and deployed to ECS Fargate.
### Multi-Stage Docker Builds
Uses multi-stage builds to create smaller, more secure production images.
### Secure HTTPS Access
TLS certificates are managed with AWS ACM and attached to the Application Load Balancer.
### Managed Database
Amazon RDS provides managed relational database storage.
### Remote Terraform State
Terraform state is stored in S3 with DynamoDB state locking for team-safe operations.
### CI/CD Ready
Designed for automated build and deployment pipelines using GitHub Actions and OpenID Connect (OIDC).

---

# What This Project Demonstrates

- End-to-end cloud infrastructure deployment  
- Real-world DevOps workflows  
- Secure AWS architecture design  
- Docker container orchestration  
- Infrastructure automation with Terraform  
- Production-ready deployment patterns

---

# Future Improvements

Future Improvements & Next Iterations
This project was intentionally scoped to demonstrate a clean, production-grade ECS deployment using modern DevOps practices. In future iterations, the following enhancements would be implemented to further align with enterprise-grade architectures:

### Network Architecture Hardening
- Migrate ECS tasks to **private subnets** with outbound access via **NAT Gateways**, reducing the public attack surface and improving network isolation.
- Remove public IP assignment from ECS tasks, relying exclusively on the Application Load Balancer for ingress traffic.

### Infrastructure as Code Security Scanning
- Integrate **Checkov** into the CI pipeline to perform static analysis on Terraform code.
- Enforce security and compliance best practices early in the deployment lifecycle.

### Container Image Vulnerability Scanning
- Add **Trivy** scans during CI to detect vulnerabilities in Docker images prior to pushing to Amazon ECR.
- Fail builds on critical or high-severity vulnerabilities to prevent insecure images from reaching production.

### CI/CD Pipeline Refinement
- Further separate pipelines into distinct stages (e.g. `plan`, `apply`, `deploy`) to better reflect real-world promotion flows.
- Introduce manual approval gates for infrastructure changes in production environments.

These improvements represent natural next steps as the project evolves and would be prioritised in a multi-environment or team-based setup.


## Setup & Reproduction

This project can be reproduced locally for container testing, or fully deployed to AWS using Terraform and GitHub Actions.


- Full GitHub Actions CI/CD pipeline  
- Blue/Green deployments  
- Autoscaling policies  
- Monitoring with CloudWatch dashboards  
- Centralised logging  
- WAF integration  
- Cost optimisation improvements


# Tech Stack

- Docker  
- Terraform  
- AWS ECS Fargate  
- ALB  
- ECR  
- Route53  
- ACM  
- RDS  
- Secrets Manager  
- GitHub Actions


