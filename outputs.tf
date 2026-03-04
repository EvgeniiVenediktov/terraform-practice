output "cluster_name" {
  description = "The name of the kind cluster."
  value       = kind_cluster.this.name
}

output "cluster_endpoint" {
  description = "The API server endpoint for the cluster."
  value       = kind_cluster.this.endpoint
}

output "kubeconfig" {
  description = "Kubeconfig for the cluster. Use: terraform output -raw kubeconfig > ~/.kube/config"
  value       = kind_cluster.this.kubeconfig
  sensitive   = true
}

output "app_namespace" {
  description = "The namespace where the demo app is deployed."
  value       = kubernetes_namespace.app.metadata[0].name
}

output "app_service" {
  description = "The ClusterIP service name for the demo app."
  value       = kubernetes_service.nginx.metadata[0].name
}
