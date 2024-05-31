

resource "aws_cloudwatch_log_group" "main" {
  name = "${var.application_name}-${var.envrionment}-lg"
}

resource "aws_ecs_cluster" "main" {
  name = "${var.application_name}-${var.envrionment}-ecs-cluster"
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
