module "redis" {
  # source = "github.com/makezbs/toolbox/modules/redis"
  source = "../../../../modules/redis/"

  name      = basename(path.cwd)
  namespace = "db"

  set = {
    "master.persistence.enabled"  = "true",
    "master.persistence.size"     = "10Gi",
    "replica.persistence.enabled" = "true",
    "replica.persistence.size"    = "10Gi",
    "replica.replicaCount"        = "2",
    "metrics.enabled"             = "true",
    "auth.enabled"                = "true",
  }
}
