resource "aws_vpc" "vpc" {
  count                = length(var.vpc_cidr_blocks)
  cidr_block           = var.vpc_cidr_blocks[count.index]
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.application_name}-${var.envrionment}-${var.aws_region}-vpc-${count.index}"
  }
}