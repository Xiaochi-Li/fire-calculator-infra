provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "Terraform" = "true"
      application = var.application_name
      envrionment = var.envrionment
    }
  }
}
