terraform {
  required_version = ">= 0.14"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "1.13.4"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }

}
