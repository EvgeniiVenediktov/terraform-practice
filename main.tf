resource "kind_cluster" "this" {
    name = var.cluster_name
    wait_for_ready = true

    kind_config {
        kind = "Cluster"
        api_version = "kind.x-k8s.io/v1alpha4"

        node {
            role = "control-plane"

            kubeadm_config_patches = [
                <<-EOF
                kind: InitConfiguration
                nodeRegistration:
                    kubeletExtraArgs:
                        node-labels: "ingress-ready=true"
                EOF
            ]

            extra_port_mappings {
                container_port = 80
                host_port = var.http_port
            }

            extra_port_mappings {
                container_port = 443
                host_port = var.https_port
            }
        }

        # Spin up # of worker nodes specified in the variable
        dynamic "node" {
            for_each = local.worker_nodes
            content {
                role = node.value.role
            }
        }
    }
}