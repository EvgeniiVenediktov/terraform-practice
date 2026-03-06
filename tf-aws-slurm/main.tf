terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


provider "aws" {
  region = var.aws_region
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  owners = [var.ami_ownerid_canonical]
}

# TODO: Head node in the VPC, public subnet
resource "aws_instance" "head_node" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.head_node_instance_type
  subnet_id = aws_subnet
  
}