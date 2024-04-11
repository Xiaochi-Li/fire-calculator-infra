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

  aws_region       = var.aws_region
  envrionment      = local.envrionment
  application_name = local.application_name
  vpc_cidr_blocks = [
    "11.16.0.0/16",
    "11.17.0.0/16",
    "11.18.0.0/16",
    "11.19.0.0/16",
    "11.20.0.0/16",
    "11.21.0.0/16"
  ]
}
