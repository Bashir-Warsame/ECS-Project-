# IAM Role for ECS Task Execution
# This role is assumed by ECS tasks to perform actions on AWS services
resource "aws_iam_role" "ecs_execution_role" {
  name = "${var.project_name}-ecs-exec-role"

  # Trust policy - defines who can assume this role
  # In this case, ECS tasks are allowed to assume it
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com" # ECS service principal
      }
      Action = "sts:AssumeRole" # allows ECS to assume this role securely
    }]
  })
}

# Attach AWS-managed policy for ECS task execution
resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name

  # This policy grants permissions needed for:
  # - Pulling container images from ECR
  # - Writing logs to CloudWatch
  # - Basic ECS task execution operations
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}