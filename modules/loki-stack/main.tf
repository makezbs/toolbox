locals {
  set = merge(local.set_defaults, var.set)
  set_defaults = {
    "fullnameOverride"   = "loki-stack",
    "fluent-bit.enabled" = "false",
    "grafana.enabled"    = "false",
    "prometheus.enabled" = "false",
    "filebeat.enabled"   = "false",
    "logstash.enabled"   = "false",
  }
  aws_enabled = length(var.aws_access_key_id) > "0" ? true : false
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

resource "kubernetes_secret" "aws_credentials" {
  count = local.aws_enabled ? 1 : 0
  metadata {
    name      = "loki-aws-credentials"
    namespace = var.namespace
  }

  type = "Opaque"

  data = {
    "aws_access_key_id"     = var.aws_access_key_id,
    "aws_secret_access_key" = var.aws_secret_access_key
  }
}

