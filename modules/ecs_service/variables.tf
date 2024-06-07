variable "application_name" {
  description = "The name of the application"
  type        = string

}

variable "vpc_id" {
  description = "The ID of the VPC to deploy the Subnets"
  type        = string
}

variable "envrionment" {
  description = "The environment"
  type        = string
}

variable "subnet_count" {
  description = "The number of subnets to create"
  type        = number
}

variable "cluster_arn" {
  description = "The ARN of the ECS cluster"
  type        = string
}

variable "task_definition_arn" {
  description = "The ARN of the ECS task definition"
  type        = string
}

variable "index" {
  description = "The index of the ECS service"
  type        = number
}

variable "container_port" {
  description = "The port the container listens on"
  type        = number
}

variable "container_name" {
  description = "The name of the container"
  type        = string
}

variable "private_subnet_ids" {
  description = "The private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "The public subnet IDs"
  type        = list(string)
}
