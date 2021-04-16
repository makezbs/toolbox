resource "kubernetes_service" "this" {
  metadata {
    name        = var.name
    namespace   = var.namespace
    annotations = local.annotations
    labels      = local.labels
  }
  spec {
    type = "ClusterIP"

    port {
      port        = 8482
      target_port = "http"
      protocol    = "TCP"
      name        = "http"
    }
    port {
      port        = 8401
      target_port = "vmselect"
      protocol    = "TCP"
      name        = "vmselect"
    }
    port {
      port        = 8400
      target_port = "vminsert"
      protocol    = "TCP"
      name        = "vminsert"
    }

    selector = local.match_labels
  }
}
