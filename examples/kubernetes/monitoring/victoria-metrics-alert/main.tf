module "victoria_metrics_alert" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/victoria-metrics-alert?ref=v0.1.0"

  set = {
    "server.datasource.url"            = "http://victoria-metrics-single:8428",
    "server.remote.write.url"          = "http://victoria-metrics-single:8428",
    "server.remote.read.url"           = "http://victoria-metrics-single:8428",
    "server.notifier.alertmanager.url" = "http://victoria-metrics-alert-alertmanager:9093",
  }
}
