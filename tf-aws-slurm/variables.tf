### --- Providers ---
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "hpc-slurm"
}

variable "ami_ownerid_canonical" {
  description = "AMI Canonical owner id"
  type        = string
  default     = "099720109477"
}

variable "head_node_instance_type" {
  type    = string
  default = "value" # TODO: define
}

variable "compute_node_instance_type" {
  type    = string
  default = "value" # TODO: define
}

variable "max_compute_nodes" {
  type    = number
  default = 5
}


### --- Networking ---
variable "vpc_cidr" {
  description = "VPC ip range."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet ip range."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Pivate subnet ip range."
  type        = string
  default     = "10.0.1.0/20" # 2^12 - 2 = 4094 (1 for net id, 1 for broadcast)
}

variable "allowed_ssh_cidrs" {
  description = "CIDRs allowed to SSH to head node."
  type        = list(string)
  default     = ["0.0.0.0/0"] # FIXME: Restrict this in production
}


### --- SSH ---
variable "ssh_key_name" {
  description = "Name of existing EC2 key pain for SSH access."
  type        = string
}
