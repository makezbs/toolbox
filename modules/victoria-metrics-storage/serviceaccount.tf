resource "kubernetes_service_account" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace

    annotations = local.annotations
    labels      = local.labels
  }
}
