output "public_subnets" {
  description = "value of public subnets"
  value       = local.public_subnets
}

output "public_route_table_id" {
  description = "value of public route table id"
  value       = aws_route_table.public[*].id
}

output "nat_eip" {
  description = "value of nat eip"
  value       = aws_eip.nat_eip[*]
}


output "private_subnets" {
  description = "value of private subnets"
  value       = local.private_subnets
}

output "private_route_table_id" {
  description = "value of private route table id"
  value       = aws_route_table.private[*].id
}

output "nat_gateway_id" {
  description = "value of nat gateway id"
  value       = aws_nat_gateway.main[*].id
}
