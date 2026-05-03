# VPC - isolated network for all AWS resources
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block         # IP range for the VPC (e.g. 10.0.0.0/16)
  enable_dns_hostnames = true                   # allows instances to have DNS names
  enable_dns_support   = true                   # enables DNS resolution within the VPC

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# INTERNET GATEWAY - enables internet access for public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# PUBLIC SUBNETS - used for internet-facing resources (e.g. ALB, NAT Gateway)
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true  # automatically assigns public IPs

  tags = {
    Name = "${var.project_name}-public-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-b"
  }
}

# PRIVATE SUBNETS - used for internal resources (e.g. ECS tasks, databases)
# No direct internet access for improved security
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "${var.project_name}-private-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "${var.project_name}-private-b"
  }
}

# PUBLIC ROUTE TABLE - routes traffic from public subnets to the internet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Default route to internet via Internet Gateway
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"             # all outbound traffic
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate public subnets with public route table
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# ELASTIC IP - static public IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}

# NAT GATEWAY - allows private subnets to access the internet securely
# (e.g. for pulling Docker images, updates, APIs)
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_a.id  # must be in a public subnet

  tags = {
    Name = "${var.project_name}-nat"
  }

  depends_on = [aws_internet_gateway.igw] # ensures IGW exists first
}

# PRIVATE ROUTE TABLE - controls outbound traffic for private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

# Route private subnet traffic to NAT Gateway (NOT directly to internet)
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

# Associate private subnets with private route table
resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}