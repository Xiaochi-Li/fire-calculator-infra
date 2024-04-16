locals {
  private_subnets = [for sn in aws_subnet.subnets : sn.id if !sn.map_public_ip_on_launch]
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "rt-private-${var.application_name}-${var.envrionment}-${var.aws_region}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(local.private_subnets)
  subnet_id      = local.private_subnets[count.index]
  route_table_id = aws_route_table.private.id
}