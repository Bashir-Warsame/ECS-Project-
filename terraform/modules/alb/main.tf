# APPLICATION LOAD BALANCER - distributes incoming traffic to ECS tasks
resource "aws_lb" "this" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"        # Layer 7 load balancer (HTTP/HTTPS)
  subnets            = var.public_subnets   # must be in public subnets to receive internet traffic
  security_groups    = [aws_security_group.alb.id] # controls inbound/outbound traffic
}

# SECURITY GROUP FOR ALB - controls what traffic can reach the load balancer
resource "aws_security_group" "alb" {
  name   = "${var.project_name}-alb-sg"
  vpc_id = var.vpc_id

  # Allow HTTPS traffic from anywhere (public access)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # open to internet (can be restricted further in production)
  }

  # Allow all outbound traffic (ALB → ECS targets)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# TARGET GROUP - where ALB sends traffic (ECS tasks register here)
resource "aws_lb_target_group" "this" {
  name        = "${var.project_name}-tg"
  port        = 8000                # container port exposed by ECS task
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"                # required for Fargate (targets are ENIs, not instances)

  # Health check to determine if targets are healthy
  health_check {
    path = "/"                      # endpoint checked by ALB
  }
}

# HTTP LISTENER - redirects all HTTP traffic to HTTPS
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  # Enforce HTTPS by redirecting all HTTP requests
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"     # permanent redirect
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
    }
  }
}

# HTTPS LISTENER - handles secure traffic and forwards to ECS
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08" # defines TLS versions/ciphers
  certificate_arn = var.certificate_arn         # SSL cert from ACM

  # Forward incoming traffic to target group (ECS tasks)
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}