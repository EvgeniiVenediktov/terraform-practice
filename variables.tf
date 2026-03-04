variable "cluster_name" {
    description = "Name of the cluster"
    type = string
    default = "tfk8s"
}

variable "worker_count" {
    description = "Number of worker nodes"
    type = number
    default = 2

    validation {
      condition = var.worker_count >= 1 && var.worker_count <= 5
      error_message = "Worker count must be more than 1 and <= 5" 
    }
}

variable "http_port" {
    description = "Host port mapped to container port 80 on the control plane"
    type = number
    default = 8080
}

variable "https_port" {
    description = "Host port mapped to container port 443 on the control plane"
    type = number
    default = 8443
}

