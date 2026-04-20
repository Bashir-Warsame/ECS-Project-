terraform {
  backend "s3" {
    bucket       = "bashir-terraform-state2"
    key          = "ecs-project/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
  }
}