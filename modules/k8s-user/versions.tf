terraform {
  required_version = "~> 1.1"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.8"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
  }

}
