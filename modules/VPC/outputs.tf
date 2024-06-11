output "vpc_ids" {
  description = "The ID of the VPC"
  value       = aws_vpc.main[*].id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main[*].cidr_block
}

output "aws_internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.main[*].id
}

output "public_subnet_ids" {
  description = "value of public subnets"
  value       = module.subnets[*].public_subnet_ids
}

output "private_subnet_ids" {
  description = "value of private subnets"
  value       = module.subnets[*].private_subnet_ids
}

output "nat_gateway_id" {
  description = "value of nat gateway id"
  value       = module.subnets[*].nat_gateway_id
}
