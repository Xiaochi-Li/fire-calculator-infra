locals {
  private_app_subnets = [for s in data.aws_subnet.app : s.id if !s.map_public_ip_on_launch]
}

resource "aws_security_group" "ecs" {
  name        = "${var.application_name}-${var.envrionment}-sg-${var.index}"
  vpc_id      = var.vpc_id
  description = "Example security group"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_out_ipv4" {
  security_group_id = aws_security_group.ecs.id
  from_port         = 0
  to_port           = 65525
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all traffic out"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_out_ipv6" {
  security_group_id = aws_security_group.ecs.id
  from_port         = 0
  to_port           = 65525
  ip_protocol       = "tcp"
  cidr_ipv6         = "::/0"
  description       = "Allow all traffic out"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_sean_ip" {
  security_group_id = aws_security_group.ecs.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "104.30.135.68/32"
  description       = "Allow SSH from Sean personal IP"
}

resource "aws_ecs_service" "main" {
  name = "${var.application_name}-${var.envrionment}-service"

  cluster         = var.cluster_arn
  task_definition = var.task_definition_arn
  launch_type     = "FARGATE"
  desired_count   = 1


  network_configuration {
    subnets          = local.private_app_subnets
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = true
  }
  # load_balancer {
  # // Tobe add later
  # }
}
