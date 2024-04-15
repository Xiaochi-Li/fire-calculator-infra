locals {
  public_subnet = [for sn in aws_subnet.subnets : sn.id if sn.map_public_ip_on_launch][0]
}

resource "aws_route_table" "public" {
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
  subnet_id      = local.public_subnet
  route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "nat" {
  subnet_id = local.public_subnet
  tags = {
    Name = "nat-${var.application_name}-${var.envrionment}-${var.aws_region}"
  }
}