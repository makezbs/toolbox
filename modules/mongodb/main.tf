locals {
  set = merge(local.set_defaults, var.set)
  set_defaults = {
    "resources.limits.memory"   = "4096Mi",
    "resources.requests.cpu"    = "1",
    "resources.requests.memory" = "2048Mi",
  }
  set_sensitive = merge(local.set_sensitive_defaults, var.set_sensitive)
  set_sensitive_defaults = {
    "auth.rootPassword"  = random_password.root_password.result,
    "auth.password"      = random_password.user_password.result,
    "auth.replicaSetKey" = random_password.replica_set_key.result,
  }
}

resource "helm_release" "this" {
  name             = var.name
  namespace        = var.namespace
  create_namespace = var.create_namespace
  version          = var.chart_version

  repository = var.repository
  chart      = var.chart

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

resource "random_password" "root_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "random_password" "user_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "random_password" "replica_set_key" {
  length           = 16
  special          = false
  override_special = "_%@"
}
