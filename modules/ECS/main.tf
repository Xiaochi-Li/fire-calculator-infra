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
      // When networkMode=awsvpc, the host ports and container ports in port mappings must match.
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
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
  cluster_arn         = aws_ecs_cluster.main.arn
  task_definition_arn = aws_ecs_task_definition.main.arn
  index               = count.index
}
