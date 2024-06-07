

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all traffic out"
  }
}

resource "aws_lb" "main" {
  name               = "main"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = data.aws_subnet.public_subnets
}

resource "aws_lb_target_group" "alb" {
  name        = "main"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
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
