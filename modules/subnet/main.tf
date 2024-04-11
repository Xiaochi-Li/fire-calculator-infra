data "aws_vpc" "selected" {
  id = var.vpc_id
}

locals {
  subnet_names = ["web", "app", "db", "reserved"]
}

resource "aws_subnet" "subnets" {
  count = length(local.subnet_names)

  vpc_id                          = var.vpc_id
  cidr_block                      = cidrsubnet(data.aws_vpc.selected.cidr_block, 4, count.index)
  ipv6_cidr_block                 = cidrsubnet(data.aws_vpc.selected.ipv6_cidr_block, 8, count.index)
  assign_ipv6_address_on_creation = true

  availability_zone       = var.availability_zone
  map_public_ip_on_launch = element(local.subnet_names, count.index) == "web" ? true : false
  tags = {
    Name = "sn-${element(local.subnet_names, count.index)}-${var.availability_zone}-${var.application_name}-${var.envrionment}"
  }
}