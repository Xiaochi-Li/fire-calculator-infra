

locals {
  envrionment      = "dev"
  application_name = "fire-calculator"
  vpc_cidr_blocks = [
    "11.16.0.0/16",
    # "11.17.0.0/16",
    # "11.18.0.0/16"
  ]
}

module "VPC_Sydney" {
  source = "../../../modules/VPC"

  aws_region       = var.aws_region
  envrionment      = local.envrionment
  application_name = local.application_name
  vpc_cidr_blocks  = local.vpc_cidr_blocks
}

module "ECS" {
  source = "../../../modules/ECS"
  count  = length(local.vpc_cidr_blocks)

  aws_region       = var.aws_region
  memory           = 2048
  cpu              = 1024
  container_port   = 8241
  container_image  = "xiaochilidevops/fire-calculator-api:latest"
  envrionment      = local.envrionment
  application_name = local.application_name
  vpc_ids          = module.VPC_Sydney.vpc_ids
}
