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

variable "vpc_id" {
  description = "value of the VPC CIDR"
  type        = string
}

variable "availability_zone" {
  description = "value of the availability zone"
  type        = string
}