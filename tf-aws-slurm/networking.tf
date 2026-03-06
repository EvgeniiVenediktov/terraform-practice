# TODO: Create VPC
resource "aws_vpc" "hpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true 
}

# TODO: Public Subnet

# TODO: Public Routing Table

# TODO: Internet Gateway

# TODO: Private Subnet

# TODO: Private Routing Table

# TODO: NAT

