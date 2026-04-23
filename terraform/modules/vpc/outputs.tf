############################################
# VPC
############################################
output "vpc_id" {
  value = aws_vpc.this.id
}

############################################
# SUBNETS
############################################
output "public_subnets" {
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

output "private_subnets" {
  value = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]
}

############################################
# ROUTE TABLES (useful for debugging / extensions)
############################################
output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

############################################
# NETWORK GATEWAYS
############################################
output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}

############################################
# CIDR (optional but useful for security groups)
############################################
output "vpc_cidr_block" {
  value = aws_vpc.this.cidr_block
}