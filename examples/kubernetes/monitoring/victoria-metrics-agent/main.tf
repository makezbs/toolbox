module "victoria_metrics_agent" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/victoria-metrics-agent?ref=v0.2.0"

  set = {
    "remoteWriteUrls[0]" : "http://vm-single.monitoring:8428/api/v1/write",
  }
}
