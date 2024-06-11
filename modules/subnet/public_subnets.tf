locals {
  public_subnets = [for sn in aws_subnet.main : sn.id if sn.map_public_ip_on_launch]
}

resource "aws_route_table" "public" {
  count  = length(local.public_subnets)
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = var.internet_gateway_id
  }

  tags = {
    Name = "rt-public-${var.application_name}-${var.envrionment}-${var.aws_region}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(local.public_subnets)
  subnet_id      = local.public_subnets[count.index]
  route_table_id = aws_route_table.public[count.index].id
}

resource "aws_eip" "nat_eip" {
  count  = length(var.availability_zones)
  domain = "vpc"

  tags = {
    Name = "nat-eip-${var.application_name}-${var.envrionment}-${var.availability_zones[count.index]}"
  }
}

resource "aws_nat_gateway" "main" {
  count         = length(var.availability_zones)
  subnet_id     = local.public_subnets[count.index]
  allocation_id = aws_eip.nat_eip[count.index].id

  tags = {
    Name = "nat-${var.application_name}-${var.envrionment}-${var.aws_region}-${count.index}"
  }
}
