module "nginx-ingress" {
  # source = "github.com/makezbs/toolbox/modules/nginx-ingress"
  source = "../../../../modules/nginx-ingress"

  name      = basename(path.cwd)
  namespace = "kube-system"

  set = {
    "ingressClass"                    = "nginx",
    "defaultBackend.image.repository" = "jshimko/default-backend",
    "defaultBackend.image.tag"        = "1.0.0"
  }
}
