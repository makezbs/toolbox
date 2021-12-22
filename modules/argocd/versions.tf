terraform {
  required_version = "~> 1.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.4"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}
