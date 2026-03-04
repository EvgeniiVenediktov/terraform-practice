cluster_name = "learn-terraform"
worker_count = 2
http_port    = 8080
app_replicas = 2

common_labels = {
  managed_by  = "terraform"
  project     = "learn-terraform"
  environment = "local"
}
