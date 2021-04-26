module "rabbitmq" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/rabbitmq?ref=v0.2.0"

  set = {
    "replicaCount"        = "1"
    "persistence.enabled" = "true",
    "persistence.size"    = "10Gi",
    "metrics.enabled"     = "true",
    "auth.username"       = "admin",
    "plugins"             = "rabbitmq_management rabbitmq_peer_discovery_k8s"
  }
}
