module "loki_stack" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/loki-stack?ref=v0.2.0"

  set = {
    "promtail.enabled"         = "true",
    "loki.persistence.enabled" = "false",
  }

  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
}
