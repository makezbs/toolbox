locals {
  set = merge(local.set_defaults, var.set)
  set_defaults = {
    "server.fullnameOverride"                = "victoria-metrics-alert",
    "server.resources.limits.memory"         = "256Mi",
    "server.resources.requests.cpu"          = "100m",
    "server.resources.requests.memory"       = "128Mi",
    "alertmanager.resources.limits.memory"   = "256Mi",
    "alertmanager.resources.requests.cpu"    = "100m",
    "alertmanager.resources.requests.memory" = "128Mi",
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
