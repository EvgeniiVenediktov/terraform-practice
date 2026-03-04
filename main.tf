### Local cluster provider; For cloud setup would be replaced for hashicorp/aws
resource "kind_cluster" "this" {
  name           = var.cluster_name
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role  = "control-plane"
      image = "kindest/node:v1.31.4"

      kubeadm_config_patches = [
        yamlencode({
          kind = "InitConfiguration"
          nodeRegistration = {
            kubeletExtraArgs = {
              node-labels = "ingress-ready=true"
            }
          }
        })
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = var.http_port
      }

      extra_port_mappings {
        container_port = 443
        host_port      = var.https_port
      }
    }

    # Spin up # of worker nodes specified in the variable
    dynamic "node" {
      for_each = local.worker_nodes
      content {
        role  = node.value.role
        image = node.value.image
      }
    }
  }
}


resource "kubernetes_namespace" "app" {
  metadata {
    name   = var.app_namespace
    labels = local.app_labels
  }

  depends_on = [kind_cluster.this]
}


resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = local.app_name
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = local.app_labels
  }

  spec {
    replicas = var.app_replicas

    selector {
      match_labels = {
        app = local.app_name
      }
    }

    template {
      metadata {
        labels = merge(local.app_labels, {
          app = local.app_name
        })
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:1.27-alpine"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "100m"
              memory = "128Mi"
            }
            requests = {
              cpu    = "50m"
              memory = "64Mi"
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "nginx" {
  metadata {
    name      = local.app_name
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = local.app_labels
  }

  spec {
    selector = {
      app = local.app_name
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
