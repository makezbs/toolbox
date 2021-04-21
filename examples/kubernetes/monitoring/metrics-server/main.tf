module "metrics_server" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/metrics-server?ref=v0.1.0"

  name      = basename(path.cwd)
  namespace = "monitoring"

  set = {}
}
