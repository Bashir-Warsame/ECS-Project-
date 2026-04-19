module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  cidr_block   = "10.0.0.0/16"
}

module "ecs" {
  source = "./modules/ecs"

  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  private_subnets    = module.vpc.private_subnets
  public_subnets     = module.vpc.public_subnets
  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  image_url          = "400528359242.dkr.ecr.eu-west-2.amazonaws.com/fastapi-app"
  target_group_arn   = module.alb.target_group_arn

  alb_security_group_id = module.alb.alb_security_group_id
}

module "alb" {
  source = "./modules/alb"

  project_name   = var.project_name
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}