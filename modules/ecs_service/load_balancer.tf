

resource "aws_security_group" "alb" {
  name        = "${var.application_name}-${var.envrionment}-alb-sg-${var.index}"
  vpc_id      = var.vpc_id
  description = "ECS security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["104.30.135.68/32"]
    description = "Allow SSH from Sean personal IP"
  }

  ingress {
    from_port       = 80
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_to_ecs" {
  security_group_id            = aws_security_group.alb.id
  from_port                    = var.container_port
  to_port                      = var.container_port
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.ecs.id
}

resource "aws_lb" "main" {
  name               = "main"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids
}

resource "aws_lb_target_group" "alb" {
  name        = "main"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/financial-profile/health-check"
    protocol            = "HTTP"
    port                = var.container_port
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.container_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }
}
