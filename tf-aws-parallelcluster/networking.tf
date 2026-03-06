resource "aws_vpc" "hpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "${var.cluster_name}-vpc" }
}

# --- Public subnet ---

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.hpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = { Name = "${var.cluster_name}-public" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.hpc.id
  tags   = { Name = "${var.cluster_name}-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.hpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "${var.cluster_name}-public-rt" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# --- Private subnet ---

resource "aws_subnet" "compute" {
  vpc_id            = aws_vpc.hpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = { Name = "${var.cluster_name}-compute" }
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = { Name = "${var.cluster_name}-nat-eip" }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags       = { Name = "${var.cluster_name}-nat" }
  depends_on = [aws_internet_gateway.igw]
}

# Outbound traffic through nat gateway
resource "aws_route_table" "compute" {
  vpc_id = aws_vpc.hpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = { Name = "${var.cluster_name}-compute-rt" }
}

resource "aws_route_table_association" "compute" {
  subnet_id      = aws_subnet.compute.id
  route_table_id = aws_route_table.compute.id
}


### --- SSH --- 
resource "aws_security_group" "head_ssh" {
  name_prefix = "${var.cluster_name}-head-ssh-"
  vpc_id      = aws_vpc.hpc.id
  description = "Allow SSH to head node from outside"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  # PC handles egress

  tags = { Name = "${var.cluster_name}-head-ssh" }
}
