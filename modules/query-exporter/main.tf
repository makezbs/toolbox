locals {
  set = merge(local.set_defaults, var.set)
  set_defaults = {
    "fullnameOverride"          = "query-exporter",
    "resources.limits.memory"   = "256Mi",
    "resources.requests.cpu"    = "50m",
    "resources.requests.memory" = "128Mi",
  }
  set_sensitive = merge(local.set_sensitive_defaults, var.set_sensitive)
  set_sensitive_defaults = {
    "example_db_connection_string" = "postgresql://postgres:password@pghost:5432/postgres",
  }
}

resource "helm_release" "this" {
  name             = var.name
  namespace        = var.namespace
  create_namespace = var.create_namespace
  version          = var.chart_version

  repository = var.repository
  chart      = var.chart

  values = [
    coalesce(fileexists(var.values_file) ? file(var.values_file) : "", file("${path.module}/values.yaml"))
  ]

  dynamic "set" {
    for_each = merge(local.set)

    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_sensitive" {
    for_each = merge(local.set_sensitive)

    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }
}
