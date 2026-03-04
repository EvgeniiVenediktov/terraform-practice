terraform {
    required_version = ">=1.5, <2.0"

    required_providers {
        kind = {
            source = "tehcyx/kind"
            version = "~> 0.7"
        }
        kubernetes = {
            source = "hashicorp/kubernetes"
            version = "~> 2.35"
        }
    }
}

provider "kind" {}

provider "kubernetes" {
    host = kind_cluster.this.endpoint
    cluster_ca_certificate = kind_cluster.this.cluster_ca_certificate
    client_certificate = kind_cluster.this.client_certificate
    client_key = kind_cluster.this.client_key 
}