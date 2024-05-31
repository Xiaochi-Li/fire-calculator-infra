resource "aws_cloudwatch_log_group" "main" {
  name = "${var.application_name}-${var.envrionment}-lg"
}

resource "aws_ecs_cluster" "main" {

  name = "${var.application_name}-${var.envrionment}-ecs-cluster"

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.main.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.main.name
      }
    }
  }
}

resource "aws_ecs_task_definition" "main" {
  family                   = "${var.application_name}-${var.envrionment}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory


  container_definitions = jsonencode([{
    name   = "${var.application_name}-${var.envrionment}-container"
    image  = var.container_image
    memory = var.memory
    cpu    = var.cpu
    portMappings = [{
      containerPort = var.container_port
      hostPort      = 80
    }]
  }])
}

resource "aws_ecs_service" "main" {
  name = "${var.application_name}-${var.envrionment}-service"

  cluster         = aws_ecs_cluster.main.arn
  task_definition = aws_ecs_task_definition.main.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  # load_balancer {
  #   // Tobe add later
  # }
}
