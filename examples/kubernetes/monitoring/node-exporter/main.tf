module "node_exporter" {
  # source = "github.com/makezbs/toolbox/modules/node-exporter"
  source = "../../../../modules/node-exporter"

  name      = basename(path.cwd)
  namespace = "monitoring"

  set = {}
}
