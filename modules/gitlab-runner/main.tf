locals {
  set = merge(local.set_defaults, var.set)
  set_defaults = {
    "concurrent"     = "3",
    "checkInterval" = "30",
  }
  set_sensitive = merge(local.set_sensitive_defaults, var.set_sensitive)
  set_sensitive_defaults = {
    "foo" = "bar",
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
