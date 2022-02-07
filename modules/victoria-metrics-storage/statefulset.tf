resource "kubernetes_stateful_set" "this" {
  metadata {
    annotations = local.annotations

    labels = local.labels

    name      = var.name
    namespace = var.namespace
  }

  spec {
    pod_management_policy  = "OrderedReady"
    replicas               = 2
    revision_history_limit = 5


    selector {
      match_labels = local.match_labels
    }

    service_name = var.name

    template {
      metadata {
        labels = local.labels

        annotations = {}
      }

      spec {
        # priority_class_name = ""
        service_account_name = kubernetes_service_account.this.metadata[0].name
        container {
          name              = var.name
          image             = "victoriametrics/vmstorage:v1.58.0-cluster"
          image_pull_policy = "IfNotPresent"

          //          args = [
          //            "--retentionPeriod '${var.retentionPeriod}'",
          //            "--storageDataPath '/storage'",
          //            "--envflag.enable true",
          //            "--envflag.prefix VM_",
          //            "--loggerFormat json",
          //          ]

          port {
            name           = "http"
            container_port = 8482
          }

          port {
            name           = "vminsert"
            container_port = 8400
          }

          port {
            name           = "vmselect"
            container_port = 8401
          }

          resources {
            limits = {
              memory = "4096Mi"
            }

            requests = {
              cpu    = "500m"
              memory = "512Mi"
            }
          }

          volume_mount {
            name       = join("-", [var.name, "data"])
            mount_path = "/storage"
            sub_path   = ""
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = "http"
            }
            initial_delay_seconds = 30
            period_seconds        = 10
            timeout_seconds       = 30
            failure_threshold     = 3
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = "http"
            }
            initial_delay_seconds = 30
            period_seconds        = 10
            timeout_seconds       = 30
            failure_threshold     = 3
          }
        }

        termination_grace_period_seconds = 300

        volume {
          name = join("-", [var.name, "data"])
          empty_dir {}
        }
      }
    }

    update_strategy {
      type = "RollingUpdate"

      rolling_update {
        partition = 1
      }
    }

    volume_claim_template {
      metadata {
        name      = join("-", [var.name, "data"])
        namespace = var.namespace
      }

      spec {
        access_modes = ["ReadWriteOnce"]
        //        storage_class_name = "standard"

        resources {
          requests = {
            storage = "16Gi"
          }
        }
      }
    }
  }
}
