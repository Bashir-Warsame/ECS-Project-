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

## Infrastructure as Code
Terraform is used to provision and manage all AWS resources in a repeatable, version-controlled way.
## Containerised Application
The FastAPI application is packaged using Docker and deployed to ECS Fargate.
## Multi-Stage Docker Builds
Uses multi-stage builds to create smaller, more secure production images.
## Secure HTTPS Access
TLS certificates are managed with AWS ACM and attached to the Application Load Balancer.
## Managed Database
Amazon RDS provides managed relational database storage.
## Remote Terraform State
Terraform state is stored in S3 with DynamoDB state locking for team-safe operations.
## CI/CD Ready
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


