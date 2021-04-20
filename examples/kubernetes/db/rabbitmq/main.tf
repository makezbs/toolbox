module "rabbitmq" {
  # source = "github.com/makezbs/toolbox/modules/rabbitmq"
  source = "../../../../modules/rabbitmq/"

  set = {
    "replicaCount"        = "1"
    "persistence.enabled" = "true",
    "persistence.size"    = "10Gi",
    "metrics.enabled"     = "true",
    "auth.username"       = "admin",
    "plugins"             = "rabbitmq_management rabbitmq_peer_discovery_k8s"
  }
}
