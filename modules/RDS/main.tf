locals {
  private_app_subnets = [for s in data.aws_subnet.private_subnets : s.id if strcontains(s.tags.Name, "sn-db")]
}

resource "aws_db_subnet_group" "main" {
  name       = "oz-fire-db-subnet-group"
  subnet_ids = local.private_app_subnets

  tags = {
    Name = "oz-fire-db-subnet-group"
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.application_name}-${var.envrionment}-rds"
  vpc_id      = var.vpc_id
  description = "ECS security group"
}

resource "aws_vpc_security_group_ingress_rule" "name" {
  count             = length(var.ecs_sg_ids)
  security_group_id = aws_security_group.rds.id
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"

  referenced_security_group_id = var.ecs_sg_ids[count.index]
}

resource "aws_db_parameter_group" "main" {
  name   = "db-mariadb-params"
  family = data.aws_rds_engine_version.main.parameter_group_family
}

resource "aws_db_instance" "main" {
  identifier              = "${var.application_name}-${var.envrionment}-db-instance"
  instance_class          = "db.t3.micro"
  allocated_storage       = 5
  engine                  = data.aws_rds_engine_version.main.engine
  engine_version          = data.aws_rds_engine_version.main.version
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  parameter_group_name    = aws_db_parameter_group.main.name
  skip_final_snapshot     = true
  backup_retention_period = 0
  apply_immediately       = true
}
