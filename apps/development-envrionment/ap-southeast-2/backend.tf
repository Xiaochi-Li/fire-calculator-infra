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
      version = "~> 5.0.0"
    }
  }
}