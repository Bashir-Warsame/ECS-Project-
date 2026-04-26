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

---

##  Architecture

![Alt text](/images/aws-diagram.png)


##  Deployment
![Alt text](/images/live-app.png)

![Alt text](/images/Terraform-plan.png)

![Alt text](/images/Terraform-apply.png)

![Alt text](/images/Terraform-destroy.png)

![Alt text](/images/Deploy-ECR.png)



## Live Endpoints

* `https://bashirwarsame.online`
* `https://api.bashirwarsame.online`




