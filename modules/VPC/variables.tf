variable "vpc_cidr_blocks" {
  description = "a list of CIDR blocks, each representing a VPC to create"
  type        = list(string)
}

variable "aws_region" {
  description = "The region to deploy the VPC"
  type        = string
}

variable "application_name" {
  description = "The name of the application"
  type        = string
}

variable "envrionment" {
  description = "The environment to deploy the VPC"
  type        = string
}