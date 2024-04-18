data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  availability_zone_names = data.aws_availability_zones.available.names
  availability_zone_count = length(local.availability_zone_names)
}

resource "aws_vpc" "main" {
  count                            = length(var.vpc_cidr_blocks)
  cidr_block                       = var.vpc_cidr_blocks[count.index]
  enable_dns_support               = true
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  tags = {
    Name = "${var.application_name}-${var.envrionment}-${var.aws_region}-vpc-${count.index}"
  }
}

resource "aws_internet_gateway" "main" {
  count  = length(aws_vpc.main)
  vpc_id = aws_vpc.main[count.index].id

  tags = {
    Name = "igw-${var.application_name}-${var.envrionment}-${count.index}"
  }
}

module "subnets" {
  count               = length(aws_vpc.main)
  source              = "../subnet"
  aws_region          = var.aws_region
  application_name    = var.application_name
  envrionment         = var.envrionment
  availability_zone   = local.availability_zone_names[count.index % local.availability_zone_count]
  vpc_id              = aws_vpc.main[count.index].id
  internet_gateway_id = aws_internet_gateway.main[count.index].id
}