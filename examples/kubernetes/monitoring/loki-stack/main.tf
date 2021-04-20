module "loki_stack" {
  # source = "github.com/makezbs/toolbox/modules/loki-stack"
  source = "../../../../modules/loki-stack/"

  set = {
    "promtail.enabled"         = "true",
    "loki.persistence.enabled" = "false",
  }

  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
}
