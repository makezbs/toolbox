locals {
  annotations = {
    "meta.terraform.io/release-name" = var.name
    "meta.terraform.io/namespace"    = var.namespace
  }

  labels = {
    "app"                          = var.name
    "app.kubernetes.io/name"       = var.name
    "app.kubernetes.io/instance"   = var.name
    "terraform.io/module"          = "victoria-metrics-storage"
    "app.kubernetes.io/managed-by" = "terraform"
  }

  match_labels = {
    "app"                        = var.name
    "app.kubernetes.io/name"     = var.name
    "app.kubernetes.io/instance" = var.name
  }
}
