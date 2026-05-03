# ECS Cluster - logical grouping for running containerised services
resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-cluster"
}

# CloudWatch Log Group - stores container logs for monitoring and debugging
resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 7 # keep logs for 7 days to balance cost and observability
}

# ECS Task Definition - defines how the container should run
resource "aws_ecs_task_definition" "this" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"] # serverless containers (no EC2 management)
  network_mode             = "awsvpc"    # each task gets its own ENI (required for Fargate)
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = var.execution_role_arn # IAM role for pulling images + logging

  # Container configuration
  container_definitions = jsonencode([
    {
      name  = "app"
      image = var.image_url # image stored in ECR

      # Expose application port
      portMappings = [
        {
          containerPort = 8000
          protocol      = "tcp"
        }
      ]

      # Send logs to CloudWatch
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.this.name
          awslogs-region        = "eu-west-2"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

# ECS Service - ensures tasks are running and handles load balancing
resource "aws_ecs_service" "this" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1 # number of running containers
  launch_type     = "FARGATE"

  # Network configuration - runs tasks in private subnets for security
  network_configuration {
    subnets          = var.private_subnets
    assign_public_ip = false # prevents direct internet exposure
    security_groups  = [aws_security_group.ecs.id]
  }

  # Attach service to ALB for external access
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "app"
    container_port   = 8000
  }
}

# Security Group for ECS tasks
resource "aws_security_group" "ecs" {
  name   = "${var.project_name}-ecs-sg"
  vpc_id = var.vpc_id

  # Allow traffic ONLY from ALB → ECS (least privilege)
  ingress {
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  # Allow outbound traffic (e.g. to pull images, call APIs)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}