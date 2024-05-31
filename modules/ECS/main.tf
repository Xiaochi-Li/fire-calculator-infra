

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

resource "aws_security_group" "ecs" {
  name        = "${var.application_name}-${var.envrionment}-sg"
  description = "Example security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["104.30.135.68/32"]
  }
}

module "ecs_service" {
  source = "../../../modules/ecs_service"
  count  = length(var.vpc_ids)

  application_name = var.application_name
  envrionment      = var.envrionment
  vpc_id           = var.vpc_ids[count.index]

}
