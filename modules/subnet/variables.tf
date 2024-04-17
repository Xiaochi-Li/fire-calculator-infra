variable "aws_region" {
  description = "The region to deploy the subnets"
  type        = string
}

variable "application_name" {
  description = "The name of the application"
  type        = string
}

variable "envrionment" {
  description = "The environment"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy the Subnets"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone to deploy the Subnets"
  type        = string
}

variable "internet_gateway_id" {
  description = "The ID of the internet gateway that will be targeted by public subnets"
  type        = string
}