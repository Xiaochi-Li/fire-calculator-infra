data "aws_subnets" "all" {
  filter {
    // only need to deploy ECS services in the app subnets
    name   = "tag:Name"
    values = ["sn-app*", "sn-web*"]
  }

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "app" {
  count = var.subnet_count
  id    = data.aws_subnets.all.ids[count.index]
}
