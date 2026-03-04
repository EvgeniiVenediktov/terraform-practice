variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
  default     = "tfk8s"
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 2

  validation {
    condition     = var.worker_count >= 1 && var.worker_count <= 5
    error_message = "Worker count must be more than 1 and <= 5"
  }
}

variable "http_port" {
  description = "Host port mapped to container port 80 on the control plane"
  type        = number
  default     = 8080
}

variable "https_port" {
  description = "Host port mapped to container port 443 on the control plane"
  type        = number
  default     = 8443
}



variable "app_namespace" {
  description = "Kubernetes namespace to deploy the demo application into."
  type        = string
  default     = "demo"
}

variable "app_replicas" {
  description = "Number of nginx pod replicas to run."
  type        = number
  default     = 2

  validation {
    condition     = var.app_replicas >= 1 && var.app_replicas <= 10
    error_message = "Replicas must be between 1 and 10."
  }
}

variable "common_labels" {
  description = "Labels applied to all resources for identification and filtering."
  type        = map(string)
  default = {
    managed_by = "terraform"
    project    = "learn-terraform"
  }
}
