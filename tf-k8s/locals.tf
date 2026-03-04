locals {
  namespace_name = "${var.cluster_name}-${var.app_namespace}"
  app_name       = "nginx-demo"

  cluster_labels = merge(var.common_labels, {
    component = "cluster"
  })

  app_labels = merge(var.common_labels, {
    component = "application"
    app       = local.app_name
  })

  worker_nodes = [
    for i in range(var.worker_count) : {
      role  = "worker"
      image = "kindest/node:v1.31.4"
    }
  ]
}
