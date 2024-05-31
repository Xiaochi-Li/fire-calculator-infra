output "nat_gateway_id" {
  description = "value of nat gateway id"
  value       = module.VPC_Sydney.nat_gateway_id
}

output "public_subnets" {
  description = "value of public subnets"
  value       = module.VPC_Sydney.public_subnets
}

output "private_subnets" {
  description = "value of private subnets"
  value       = module.VPC_Sydney.private_subnets
}
