variable "project_name" {
    type = string
}

variable "vpc_id" {}

variable "private_subnets" {
  type = list(string)
}
variable "execution_role_arn" {}

variable "image_url" {}

variable "target_group_arn" {}

variable "alb_security_group_id" {
    type = string
}
variable "public_subnets" {
  type = list(string)
}