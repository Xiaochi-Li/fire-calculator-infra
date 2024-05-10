# Terraform AWS VPC Module

This module takes a list of CIDR blocks and creates Virtual Private Cloud (VPC)s for each given CIDR block, along with associated resources.

## Features

Create multiple VPCs, and create below resource within each VPC.

1. subnets - Equally divide VPC in to 4 subnets `web`, `app`, `db` and `reserve`.
2. `web` is the public subnet which is associated with an Internet Gateway. An NAT gateway is also created in `web` to handle traffic from private subnets to the public internet.
3. `app`, `db` and `reserve` are private subnets.

## Usage

```terraform
module "vpc" {
  source              = "../modules/VPC"
  vpc_cidr_blocks     = ["10.0.0.0/16", "10.1.0.0/16"]
  aws_region          = "us-west-2"
  application_name    = "myapp"
  environment         = "dev"
}
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_subnets"></a> [subnets](#module\_subnets) | ../subnet | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The name of the application | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The region to deploy the VPC | `string` | n/a | yes |
| <a name="input_envrionment"></a> [envrionment](#input\_envrionment) | The environment to deploy the VPC | `string` | n/a | yes |
| <a name="input_vpc_cidr_blocks"></a> [vpc\_cidr\_blocks](#input\_vpc\_cidr\_blocks) | a list of CIDR blocks, each representing a VPC to create | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_internet_gateway_id"></a> [aws\_internet\_gateway\_id](#output\_aws\_internet\_gateway\_id) | The ID of the internet gateway |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->


## Requirements

Terraform 0.12+
AWS provider

## Notes

This module creates one VPC for each CIDR block specified in vpc_cidr_blocks. It also creates an Internet Gateway for each VPC, and associates the Internet Gateway with the VPC. The module then creates Subnets within each VPC.

The module uses the aws_availability_zones data source to get a list of availability zones in the specified region, and creates Subnets in these availability zones.

Please use this module with caution, as it can create significant resources in your AWS account which may cost you money.