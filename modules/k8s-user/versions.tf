terraform {
  required_version = "~> 1.2"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.15"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.2"
    }
  }

}
