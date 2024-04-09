terraform {
  cloud {
    organization = "sean-li-terraform-cloud-learning"

    workspaces {
      name = "fire-calculator-infra-development"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  envrionment      = "dev"
  application_name = "fire-calculator"
}

module "VPC_Melbourne" {
  source                       = "../../../modules/VPC"
  number_of_availability_zones = 3
  aws_region                   = var.aws_region
  application_name             = local.application_name
  envrionment                  = local.envrionment
  vpc_cidr_blocks = [
    "11.22.0.0/16",
    "11.23.0.0/16",
    "11.24.0.0/16",
    "11.25.0.0/16",
    "11.26.0.0/16",
    "11.27.0.0/16",
  ]
}