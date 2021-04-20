module "victoria_metrics_alert" {
  # source = "github.com/makezbs/toolbox/modules/victoria-metrics-alert"
  source = "../../../../modules/victoria-metrics-alert"

  set = {
    "server.datasource.url"            = "http://victoria-metrics-single:8428",
    "server.remote.write.url"          = "http://victoria-metrics-single:8428",
    "server.remote.read.url"           = "http://victoria-metrics-single:8428",
    "server.notifier.alertmanager.url" = "http://victoria-metrics-alert-alertmanager:9093",
  }
}
