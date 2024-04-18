# Terraform AWS VPC Module

This module takes a list of CIDR blocks and creates Virtual Private Cloud (VPC)s for each given CIDR block, along with associated resources.

## Features

Create multiple VPCs, and create below resource within each VPC.

1. subnets - Equally divide VPC in to 4 subnets `web`, `app`, `db` and `reserve`.
2. `web` is the public subnet which is associated with an Internet Gateway. An NAT gateway is also created in `web` to handle traffic from private subnets to the public internet.
3. `app`, `db` and `reserve` are private subnets.

### Usage

```terraform
module "vpc" {
  source              = "../modules/VPC"
  vpc_cidr_blocks     = ["10.0.0.0/16", "10.1.0.0/16"]
  aws_region          = "us-west-2"
  application_name    = "myapp"
  environment         = "dev"
}
```

### Inputs

vpc_cidr_blocks: List of CIDR blocks to be used for the VPCs.
aws_region: The AWS region where the resources will be created.
application_name: The name of the application. This will be used in naming resources.
environment: The environment (e.g., "dev", "prod"). This will be used in naming resources.

### Outputs
N/A

### Requirements

Terraform 0.12+
AWS provider

### Notes

This module creates one VPC for each CIDR block specified in vpc_cidr_blocks. It also creates an Internet Gateway for each VPC, and associates the Internet Gateway with the VPC. The module then creates Subnets within each VPC.

The module uses the aws_availability_zones data source to get a list of availability zones in the specified region, and creates Subnets in these availability zones.

Please use this module with caution, as it can create significant resources in your AWS account which may cost you money.
