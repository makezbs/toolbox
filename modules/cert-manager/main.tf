locals {
  set = merge(local.set_defaults, var.set)
  set_defaults = {
    "fullnameOverride" = "cert-manager",
  }
  cloudflare_enabled = length(var.cloudflare_api_token) > "0" ? true : false
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

resource "kubernetes_secret" "cf_api_key" {
  count = local.cloudflare_enabled ? 1 : 0
  metadata {
    name      = "cloudflare-api-token"
    namespace = var.namespace
  }

  type = "Opaque"

  data = {
    "api-token" = var.cloudflare_api_token
  }
}
