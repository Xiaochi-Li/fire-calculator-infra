variable "private_subnet_ids" {
  description = "The private subnet IDs"
  type        = list(string)
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "application_name" {
  description = "The name of the application"
  type        = string
}

variable "envrionment" {
  description = "The environment the application is deployed to"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "ecs_sg_ids" {
  description = "The ECS security group ID"
  type        = list(string)
}
