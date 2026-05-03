# FastAPI URL Shortener on AWS ECS (Terraform)

A production-style DevOps project deploying a Dockerised FastAPI application to AWS ECS Fargate using Terraform.
This project provisions AWS infrastructure and deploys a containerised FastAPI app behind an Application Load Balancer.

##  Overview

This project provisions cloud infrastructure and deploys a containerized FastAPI app with:

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

## Infrastructure Overview

The application is deployed as a stateless containerised service on AWS ECS Fargate, running within private subnets for enhanced security.
It is exposed to users via an Application Load Balancer (ALB), which handles incoming traffic and distributes it across healthy ECS tasks.

Traffic is routed through Route 53, providing DNS resolution for a custom domain, and secured using AWS Certificate Manager (ACM) to enable HTTPS with managed TLS certificates.

Container images are built and stored in Amazon ECR, allowing ECS to pull versioned images during deployments.
Application logs are streamed to CloudWatch Logs, enabling monitoring, troubleshooting, and observability.

All infrastructure is provisioned using Terraform, following Infrastructure as Code principles.
Terraform state is stored remotely in S3, with DynamoDB used for state locking to prevent concurrent modifications and ensure consistency.
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
### ACM Certificate
![Alt text](/images/acm_cert.png)



## Live Endpoints

* `https://bashirwarsame.online`
* `https://api.bashirwarsame.online`

---

# What This Project Demonstrates

- End-to-end cloud infrastructure deployment  
- Real-world DevOps workflows  
- Secure AWS architecture design  
- Docker container orchestration  
- Infrastructure automation with Terraform  
- Production-ready deployment patterns

---
## Data Flow
### User Traffic

Users access the application via a custom domain:

Users → Route 53 → Application Load Balancer → ECS Fargate (container port 8000)

Route 53 resolves the domain name to the ALB
The ALB terminates HTTPS using ACM certificates
Traffic is forwarded to ECS tasks running in private subnets
Only healthy containers receive traffic via target group health checks

---

## CI/CD Pipeline

Application deployments are fully automated:

GitHub Actions → Docker Build → Amazon ECR → ECS Service Updat

- GitHub Actions builds the Docker image  
- The image is tagged using the commit SHA and pushed to ECR  
- ECS service is updated, triggering a new deployment  
- New tasks pull the latest image and replace old running tasks  

---

## Infrastructure Provisioning

Infrastructure is managed declaratively:

Terraform → AWS (VPC, Subnets, ALB, ECS, ECR, ACM, Route 53)

- Terraform defines all AWS resources as code  
- Changes are applied via CI/CD pipelines  
- Remote state ensures consistency across environments  

---

# Future Improvements

Future Improvements & Next Iterations
This project was intentionally scoped to demonstrate a clean, production-grade ECS deployment using modern DevOps practices. In future iterations, the following enhancements would be implemented to further align with enterprise-grade architectures:

### DevSecOps Enhancements
- Integrate SAST and dependency scanning into the CI/CD pipeline
- Add container image scanning before pushing to ECR
- Introduce AWS WAF in front of the ALB to protect against common web attacks 
- Enforce stricter IAM least privilege policies and role separation

### Deployment Strategies
- mplement blue/green deployments using AWS CodeDeploy with ECS
- Add canary deployments to gradually shift traffic
- Introduce automated rollback based on health checks or alarms

### Scalability & Performance
- Configure ECS Service Auto Scaling based on CPU/memory or request count
- Add caching layer (e.g. Redis / ElastiCache) for faster URL lookups
- Optimise container performance and resource allocation

### Observability & Monitoring
- Enhance logging with structured logs and correlation IDs
- Add CloudWatch dashboards and alarms for proactive monitoring
- Integrate distributed tracing (e.g. AWS X-Ray)
- Add alerting (e.g. Slack/email notifications) for failures

### Security & Networking
- Use VPC endpoints to avoid public internet access for AWS services
- Restrict outbound traffic instead of allowing 0.0.0.0/0
- Implement Secrets Manager rotation for credentials

These improvements represent natural next steps as the project evolves and would be prioritised in a multi-environment or team-based setup.

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


