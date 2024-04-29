output "public_subnets" {
  description = "value of public subnets"
  value       = local.public_subnet
}

output "private_subnets" {
  description = "value of private subnets"
  value       = local.private_subnets
}

output "nat_gateway_id" {
  description = "value of nat gateway id"
  value       = aws_nat_gateway.main.id
}