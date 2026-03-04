terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}



provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "example" {
  ami           = "ami-04752fceda1274920"
  instance_type = "t3.micro"

}