locals {
  private_subnets = [for sn in aws_subnet.main : sn.id if !sn.map_public_ip_on_launch]
}

resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name = "rt-private-${var.application_name}-${var.envrionment}-${var.availability_zones[count.index]}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(local.private_subnets)
  subnet_id      = local.private_subnets[count.index]
  route_table_id = aws_route_table.private[floor(count.index / length(aws_route_table.private))].id
}
