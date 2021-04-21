module "victoria_metrics_single" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/victoria-metrics-single?ref=v0.1.0"

  name      = basename(path.cwd)
  namespace = "monitoring"

  set = {
    "server.retentionPeriod"          = "1",
    "server.persistentVolume.enabled" = "true",
    "server.persistentVolume.size"    = "50Gi",
  }
}
