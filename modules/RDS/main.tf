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

resource "aws_security_group" "main" {
  name        = "${var.application_name}-${var.envrionment}-rds"
  vpc_id      = var.vpc_id
  description = "ECS security group"
}

resource "aws_db_parameter_group" "main" {
  name   = "db-mariadb-params"
  family = data.aws_rds_engine_version.main.parameter_group_family
}

resource "aws_db_instance" "main" {
  identifier              = "main"
  instance_class          = "db.t3.micro"
  allocated_storage       = 5
  engine                  = data.aws_rds_engine_version.main.engine
  engine_version          = data.aws_rds_engine_version.main.version
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.main.id]
  parameter_group_name    = aws_db_parameter_group.main.name
  skip_final_snapshot     = true
  backup_retention_period = 0
  apply_immediately       = true
}
