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
    "11.16.0.6/16",
    "11.16.0.7/16",
    "11.16.0.8/16",
    "11.16.0.9/16",
    "11.16.0.10/16",
    "11.16.0.11/16"
  ]
}