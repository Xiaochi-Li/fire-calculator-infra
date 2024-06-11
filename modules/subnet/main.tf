locals {
  subnet_names = ["web", "app", "db", "reserved"]

  subnet_az_pairs = flatten([
    for az in var.availability_zones : [
      for name in local.subnet_names : {
        name = name
        az   = az
      }
    ]
  ])
}

resource "aws_subnet" "main" {
  count = length(local.subnet_az_pairs)

  vpc_id                          = var.vpc_id
  cidr_block                      = cidrsubnet(data.aws_vpc.selected.cidr_block, 4, count.index)
  ipv6_cidr_block                 = cidrsubnet(data.aws_vpc.selected.ipv6_cidr_block, 4, count.index)
  assign_ipv6_address_on_creation = true

  availability_zone = local.subnet_az_pairs[count.index].az

  map_public_ip_on_launch = local.subnet_az_pairs[count.index].name == "web" ? true : false
  tags = {
    Name = "sn-${local.subnet_az_pairs[count.index].name}-${local.subnet_az_pairs[count.index].az}-${var.application_name}-${var.envrionment}"
  }
}
