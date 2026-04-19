variable "project_name" {}
variable "vpc_id" {}
variable "public_subnets" {
  type = list(string)
}
variable "certificate_arn" {
  type = string
}
