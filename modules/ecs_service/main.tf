locals {
  private_app_subnets = [for s in data.aws_subnet.private_subnets : s.id if strcontains(s.tags.Name, "sn-app")]
}

resource "aws_security_group" "ecs" {
  name        = "${var.application_name}-${var.envrionment}-ecs-sg-${var.index}"
  vpc_id      = var.vpc_id
  description = "ECS security group"
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

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_seans_ip" {
  security_group_id = aws_security_group.ecs.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"

  referenced_security_group_id = aws_security_group.alb.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_from_alb" {
  security_group_id            = aws_security_group.ecs.id
  from_port                    = var.container_port
  to_port                      = var.container_port
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.alb.id
}

resource "aws_ecs_service" "main" {
  name = "${var.application_name}-${var.envrionment}-service"

  cluster              = var.cluster_arn
  task_definition      = var.task_definition_arn
  launch_type          = "FARGATE"
  desired_count        = 1
  force_new_deployment = true


  network_configuration {
    subnets          = local.private_app_subnets
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
  # The Amazon ECS service requires an explicit dependency on the Application
  # Load Balancer listener rule and the Application Load Balancer listener. 
  # This prevents the service from starting before the listener is ready.
  depends_on = [aws_lb_listener.front_end]
}


