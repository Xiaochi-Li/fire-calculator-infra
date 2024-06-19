locals {
  container_name = "${var.application_name}-${var.envrionment}-container"
}

resource "aws_ecs_cluster" "main" {
  name = "${var.application_name}-${var.envrionment}-ecs-cluster"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "${var.application_name}-log"

  retention_in_days = 7

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
  }
}

resource "aws_iam_role" "execution_role" {
  name = "${var.application_name}-${var.envrionment}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_ecs_task_definition" "main" {
  family                   = "${var.application_name}-${var.envrionment}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.execution_role.arn

  container_definitions = jsonencode([{
    name   = local.container_name
    image  = var.container_image
    memory = var.memory
    cpu    = var.cpu
    healthcheck = {
      command      = ["CMD-SHELL", "curl -f http://localhost:${var.container_port}/financial-profile/health-check || exit 1"]
      interval     = 30
      timeout      = 5
      retries      = 3
      start_period = 60
    }
    portMappings = [{
      // When networkMode=awsvpc, the host ports and container ports in port mappings must match.
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-create-group"  = true
        "awslogs-group"         = aws_cloudwatch_log_group.main.name
        "awslogs-region"        = var.aws_region
        "awslogs-stream-prefix" = "${var.application_name}-${var.envrionment}"
      }
    }
  }])
}


module "ecs_service" {
  source = "../ecs_service"
  count  = length(var.vpc_ids)

  application_name    = var.application_name
  envrionment         = var.envrionment
  vpc_id              = var.vpc_ids[count.index]
  container_port      = var.container_port
  cluster_arn         = aws_ecs_cluster.main.arn
  subnet_count        = 1
  task_definition_arn = aws_ecs_task_definition.main.arn
  index               = count.index
  container_name      = local.container_name
  private_subnet_ids  = var.private_subnet_ids
  public_subnet_ids   = var.public_subnet_ids
}
