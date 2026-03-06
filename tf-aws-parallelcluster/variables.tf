### --- Providers ---
variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "cluster_name" {
  type    = string
  default = "hpc-pcluster"
}

variable "head_node_instance_type" {
  type    = string
  default = "c7g.xlarge"
}

variable "compute_node_instance_type" {
  description = "EFA-enabled HPC instance type."
  type        = string
  default     = "hpc7g.4xlarge"
}

variable "max_compute_nodes" {
  type    = number
  default = 5
}

variable "min_compute_nodes" {
  type    = number
  default = 0
}

variable "scaledown_idletime" {
  description = "Idle time befor scaling down (minutes)."
  type        = number
  default     = 5
}

### --- Storage ---

variable "fsx_storage_capacity" {
  description = "FSx Lustre capacity in GiB (minimum 1200)."
  type        = number
  default     = 1200
}

variable "fsx_throughput_per_unit" {
  description = "MB/s per TiB for PERSISTENT_2 Lustre."
  type        = number
  default     = 250
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
  default     = "10.0.16.0/20" # 2^12 - 2 = 4094 (1 for net id, 1 for broadcast)
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
  default     = "hpc-key"
}
