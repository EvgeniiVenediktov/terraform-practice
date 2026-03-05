variable "instance_name" {
  description = "Instance name."
  type        = string
  default     = "Hello World"
}

variable "aws_region" {
  description = "AWS region for the cluster."
  type        = string
  default     = "us-east-1"

}

variable "ami_ownerid_canonical" {
  description = "AMI Canonical owner id"
  type        = string
  default     = "099720109477"
}