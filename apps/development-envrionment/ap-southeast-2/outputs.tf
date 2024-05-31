output "nat_gateway_id" {
  description = "value of nat gateway id"
  value       = module.VPC_Sydney.nat_gateway_id
}

output "vpc_ids" {
  description = "The ID of the VPC"
  value       = module.VPC_Sydney.vpc_ids
}

output "public_subnets" {
  description = "value of public subnets"
  value       = module.VPC_Sydney.public_subnets
}

output "private_subnets" {
  description = "value of private subnets"
  value       = module.VPC_Sydney.private_subnets
}
