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

## Inputs

- `vpc_id`: The ID of the VPC where the subnets will be created.
- `availability_zone`: The availability zone where the subnets will be created.
- `application_name`: The name of the application. This will be used in naming resources.
- `envrionment`: The environment (e.g., "dev", "prod"). This will be used in naming resources.
- `internet_gateway_id`: The ID of the Internet Gateway associated with the VPC.

## Outputs

- `private_subnets`: The IDs of the created private subnets.
- `public_subnet`: The ID of the created public subnet.
- `nat_gateway_id`: The ID of the created NAT Gateway.

## Requirements

- Terraform 0.12+
- AWS provider

## Notes

This module creates four subnets: "web", "app", "db", and "reserved". The "web" subnet is a public subnet, and the others are private. The module creates a public Route Table and a private Route Table, and associates the subnets with the appropriate Route Tables. The module also creates a NAT Gateway in the public subnet and allocates an Elastic IP to the NAT Gateway.

Please use this module with caution, as it can create significant resources in your AWS account which may cost you money.