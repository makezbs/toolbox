module "node_exporter" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/node-exporter?ref=v0.1.0"

  name      = basename(path.cwd)
  namespace = "monitoring"

  set = {}
}
