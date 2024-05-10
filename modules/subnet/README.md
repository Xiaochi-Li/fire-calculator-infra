# Terraform AWS VPC Subnets Module

This module creates subnets within a specified Virtual Private Cloud (VPC) in AWS, along with associated resources such as Route Tables, NAT Gateways, and Elastic IPs.

## Features

- Creates a public subnet named `web` and private subnets named `db`, `app`, and `reserved` within a specified VPC.
- Assigns CIDR blocks to the subnets.
- Enables IPv6 within the subnets.
- Creates public and private Route Tables.
- Associates subnets with the appropriate Route Tables.
- Creates a NAT Gateway in the public subnet.
- Allocates an Elastic IP to the NAT Gateway.

## Usage

```hcl
module "subnets" {
  source              = "../subnets"
  vpc_id              = "vpc-0abcd1234efgh5678"
  availability_zone   = "us-west-2a"
  application_name    = "myapp"
  envrionment         = "dev"
  internet_gateway_id = "igw-0abcd1234efgh5678"
}
```

## Requirements

- Terraform 0.12+
- AWS provider

## Notes

This module creates four subnets: "web", "app", "db", and "reserved". The "web" subnet is a public subnet, and the others are private. The module creates a public Route Table and a private Route Table, and associates the subnets with the appropriate Route Tables. The module also creates a NAT Gateway in the public subnet and allocates an Elastic IP to the NAT Gateway.

Please use this module with caution, as it can create significant resources in your AWS account which may cost you money.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_nat_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The name of the application | `string` | n/a | yes |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The availability zone to deploy the Subnets | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The region to deploy the subnets | `string` | n/a | yes |
| <a name="input_envrionment"></a> [envrionment](#input\_envrionment) | The environment | `string` | n/a | yes |
| <a name="input_internet_gateway_id"></a> [internet\_gateway\_id](#input\_internet\_gateway\_id) | The ID of the internet gateway that will be targeted by public subnets | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to deploy the Subnets | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | value of nat gateway id |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | value of private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | value of public subnets |