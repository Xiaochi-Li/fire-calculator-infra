data "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_ids)
  id    = var.private_subnet_ids[count.index]
}

data "aws_rds_engine_version" "main" {
  engine       = "mariadb" #Standard Edition
  default_only = true
}
