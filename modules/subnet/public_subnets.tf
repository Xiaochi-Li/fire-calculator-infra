locals {
  public_subnets  = [for sn in aws_subnet.subnets : sn.id if sn.map_public_ip_on_launch]
  private_subnets = [for sn in aws_subnet.subnets : sn.id if !sn.map_public_ip_on_launch]
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
    Name = "rt-public-${var.application_name}-${var.envrionment}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(local.public_subnets)
  subnet_id      = local.public_subnets[count.index]
  route_table_id = aws_route_table.public.id
}