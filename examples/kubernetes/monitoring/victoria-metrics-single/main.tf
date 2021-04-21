module "victoria_metrics_single" {
  # source = "github.com/makezbs/toolbox/modules/victoria-metrics-single"
  source = "../../../../modules/victoria-metrics-single"

  name      = basename(path.cwd)
  namespace = "monitoring"

  set = {
    "server.retentionPeriod"          = "1",
    "server.persistentVolume.enabled" = "true",
    "server.persistentVolume.size"    = "50Gi",
  }
}
