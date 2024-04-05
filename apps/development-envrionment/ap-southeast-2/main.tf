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

module "VPC_Sydney" {
  source = "../../../modules/VPC"

  number_of_availability_zones = 3
  aws_region                   = var.aws_region
  envrionment                  = local.envrionment
  application_name             = local.application_name
  vpc_cidr_blocks = [
    "11.16.0.0/16",
    "11.16.0.1/16",
    "11.16.0.2/16",
    "11.16.0.3/16",
    "11.16.0.4/16",
    "11.16.0.5/16"
  ]
}
