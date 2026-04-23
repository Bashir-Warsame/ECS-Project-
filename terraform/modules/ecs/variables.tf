variable "project_name" {
    type = string
}
variable "vpc_id" {
    type = string
}
variable "private_subnets" {
  type = list(string)
}
variable "execution_role_arn" {
    type = string
}
variable "image_url" {
    type = string
}
variable "target_group_arn" {
    type = string
}
variable "alb_security_group_id" {
    type = string
}
variable "public_subnets" {
  type = list(string)
}