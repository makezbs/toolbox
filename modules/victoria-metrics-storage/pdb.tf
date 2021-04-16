resource "kubernetes_pod_disruption_budget" "demo" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = local.labels
  }
  spec {
    # max_unavailable = "1"
    min_available = "1"
    selector {
      match_labels = local.match_labels
    }
  }
}
