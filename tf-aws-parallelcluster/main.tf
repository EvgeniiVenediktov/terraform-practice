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


# ParallelCluster config

resource "local_file" "pcluster_config" {
  filename        = "${path.module}/generated/cluster-config.yaml"
  file_permission = "0644"

  content = templatefile("${path.module}/templates/cluster-config.yaml.tftpl", {
    # Region
    aws_region = var.aws_region

    # Head node
    head_node_instance_type = var.head_node_instance_type
    public_subnet_id        = aws_subnet.public.id
    head_ssh_sg_id          = aws_security_group.head_ssh.id
    ssh_key_name            = var.ssh_key_name

    # Compute
    compute_subnet_id     = aws_subnet.compute.id
    compute_instance_type = var.compute_node_instance_type
    min_compute_nodes     = var.min_compute_nodes
    max_compute_nodes     = var.max_compute_nodes
    scaledown_idletime    = var.scaledown_idletime
  })
}