variable "vpc_cidr_blocks" {
  description = "The CIDR block for the VPC"
  type        = list(string)
}

variable "number_of_availability_zones" {
  description = "The number of availability zones to use"
  type        = number
  default     = 1
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