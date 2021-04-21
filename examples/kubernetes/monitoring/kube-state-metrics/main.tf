module "kube_state_metrics" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/kube-state-metrics?ref=v0.1.0"

  name      = basename(path.cwd)
  namespace = "monitoring"

  set = {}
}
