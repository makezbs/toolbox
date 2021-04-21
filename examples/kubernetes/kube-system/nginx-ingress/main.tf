module "nginx-ingress" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/nginx-ingress?ref=v0.1.0"

  name      = basename(path.cwd)
  namespace = "kube-system"

  set = {
    "ingressClass"                    = "nginx",
    "defaultBackend.image.repository" = "jshimko/default-backend",
    "defaultBackend.image.tag"        = "1.0.0"
  }
}
