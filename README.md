# FastAPI URL Shortener on AWS ECS (Terraform)

A production-style DevOps project deploying a Dockerised FastAPI application to AWS ECS Fargate using Terraform.
This project provisions AWS infrastructure and deploys a containerised FastAPI app behind an Application Load Balancer.

##  Overview

This project provisions cloud infrastructure and deploys a containerized FastAPI app with:

###  Infrastructure as Code
- Terraform is used to provision and manage all AWS resources in a repeatable, version-controlled way
- Ensures consistency across environments and enables safe infrastructure changes

###  Containerised Application
- FastAPI application is packaged using Docker
- Deployed to AWS ECS Fargate as a stateless containerised service behind an ALB

###  Docker Builds
- Uses a lightweight 'pyhton:3.11-slim' base image to keep container small and efficient
- Installs only the required application dependencies using requirements.text
-runs the app as a non-root user to improves security and reduce privilege risks

###  Secure HTTPS Access
- TLS certificates are managed using AWS Certificate Manager (ACM)
- Attached to the Application Load Balancer to enforce HTTPS

###  Remote Terraform State
- Terraform state is stored in Amazon S3
- DynamoDB is used for state locking to prevent concurrent modifications

###  CI/CD Ready
- Designed for automated deployments using GitHub Actions
- Uses OpenID Connect (OIDC) for secure authentication without long-lived credentials

----

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

##  Data Flow – User Traffic

Users access the application via a custom domain hosted in Route 53.

Users → Route 53 → Application Load Balancer (ALB) → ECS Fargate (private subnets, port 8000)

- Route 53 resolves the domain name to the ALB DNS record  
- The ALB is deployed in public subnets and acts as the internet-facing entry point  
- HTTPS traffic is terminated at the ALB using ACM-managed TLS certificates  
- The ALB forwards requests to ECS Fargate tasks running in private subnets  
- Only healthy containers receive traffic based on ALB target group health checks  

##  Network Flow (Internal Architecture)

- ECS tasks run in **private subnets** with no direct internet exposure  
- A **NAT Gateway in a public subnet** provides outbound internet access for private resources  
- NAT routes traffic through the **Internet Gateway** to access external services (e.g. package downloads, APIs)  

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

Terraform → AWS (VPC, ALB, ECS, ACM, DNS)

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


