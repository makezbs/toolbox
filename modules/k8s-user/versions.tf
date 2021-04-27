terraform {
  required_version = ">= 0.14"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }

}