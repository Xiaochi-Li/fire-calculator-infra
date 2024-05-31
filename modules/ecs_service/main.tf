locals {
  private_subnets = [for sn in aws_subnets.main : sn.id if !sn.map_public_ip_on_launch]
}

resource "aws_ecs_service" "main" {
  name = "${var.application_name}-${var.envrionment}-service"

  cluster         = aws_ecs_cluster.main.arn
  task_definition = aws_ecs_task_definition.main.arn
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
