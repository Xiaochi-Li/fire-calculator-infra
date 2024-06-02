provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "Terraform" = "true"
      application = local.application_name
      envrionment = local.envrionment
    }
  }
}
