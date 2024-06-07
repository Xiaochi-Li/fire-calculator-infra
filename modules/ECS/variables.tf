
variable "application_name" {
  description = "The name of the application"
  type        = string
}

variable "envrionment" {
  description = "The environment"
  type        = string
}

variable "container_image" {
  description = "The container image to deploy"
  type        = string
}

variable "container_port" {
  description = "The port the container listens on"
  type        = number
}

variable "cpu" {
  description = "The amount of CPU to allocate to the container"
  type        = number
}

variable "memory" {
  description = "The amount of memory to allocate to the container"
  type        = number
}

variable "aws_region" {
  description = "The region to deploy the ECS cluster"
  type        = string
}

variable "vpc_ids" {
  description = "The VPC ID"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "The private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "The public subnet IDs"
  type        = list(string)
}
