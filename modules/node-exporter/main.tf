locals {
  set = merge(local.set_defaults, var.set)
  set_defaults = {
    "fullnameOverride"          = "node-exporter",
    "resources.limits.memory"   = "256Mi",
    "resources.requests.cpu"    = "100m",
    "resources.requests.memory" = "128Mi",
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
}
