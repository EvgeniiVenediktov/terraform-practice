output "vpc_id" {
  value = aws_vpc.hpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "compute_subnet_id" {
  value = aws_subnet.compute.id
}

output "cluster_config_path" {
  value = local_file.pcluster_config.filename
}

output "cluster_name" {
  value = var.cluster_name
}