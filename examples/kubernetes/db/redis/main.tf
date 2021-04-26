module "redis" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/redis?ref=v0.2.0"

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
