locals {
  set = merge(local.set_defaults, var.set)
  set_defaults = {
    "server.fullnameOverride"                                    = "victoria-metrics-agent",
    "extraArgs.promscrape\\.suppressDuplicateScrapeTargetErrors" = "true",
    "rbac.create"                                                = "true",
    "rbac.pspEnabled"                                            = "true",
    "resources.limits.memory"                                    = "2048Mi",
    "resources.requests.cpu"                                     = "200m",
    "resources.requests.memory"                                  = "512Mi",

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
    for_each = local.set

    content {
      name  = set.key
      value = set.value
    }
  }
}
