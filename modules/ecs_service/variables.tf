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
