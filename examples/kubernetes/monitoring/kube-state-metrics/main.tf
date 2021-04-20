module "victoria_metrics_single" {
  # source = "github.com/makezbs/toolbox/modules/kube-state-metrics"
  source = "../../../../modules/kube-state-metrics"

  name      = basename(path.cwd)
  namespace = "monitoring"

  set = {}
}
