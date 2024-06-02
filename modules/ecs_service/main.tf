locals {
  private_subnets = [for s in data.aws_subnet.each : s.id if !s.map_public_ip_on_launch]
}

resource "aws_security_group" "ecs" {
  name        = "${var.application_name}-${var.envrionment}-sg-${var.index}"
  vpc_id      = var.vpc_id
  description = "Example security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["104.30.135.68/32"]
  }
}

resource "aws_ecs_service" "main" {
  name = "${var.application_name}-${var.envrionment}-service"

  cluster         = var.cluster_arn
  task_definition = var.task_definition_arn
  launch_type     = "FARGATE"
  desired_count   = 1


  network_configuration {
    subnets          = local.private_subnets
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = true
  }
  # load_balancer {
  # // Tobe add later
  # }
}