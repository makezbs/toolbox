module "metrics_server" {
  # source = "github.com/makezbs/toolbox/modules/metrics-server"
  source = "../../../../modules/metrics-server"

  name      = basename(path.cwd)
  namespace = "monitoring"

  set = {}
}
