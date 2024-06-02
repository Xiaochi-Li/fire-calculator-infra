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
