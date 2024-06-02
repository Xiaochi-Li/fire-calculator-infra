data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}
data "aws_subnet" "each" {
  count = var.subnet_count
  id    = data.aws_subnets.all.ids[count.index]
}
