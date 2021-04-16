module "victoria_metrics_agent" {
  source = "../../../../modules/victoria-metrics-agent/"

  set = {
    "remoteWriteUrls[0]" : "http://vm-single.monitoring:8428/api/v1/write",
  }
}
