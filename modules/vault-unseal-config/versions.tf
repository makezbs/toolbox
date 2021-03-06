terraform {
  required_version = "~> 1.1"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.7"
    }
  }
}
