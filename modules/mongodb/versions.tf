terraform {
  required_version = ">= 0.14"

  required_providers {
    google = {
      source  = "hashicorp/helm"
      version = "2.1"
    }

    vault = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

}

provider "helm" {
  # export KUBE_CONFIG_PATHS=
}
