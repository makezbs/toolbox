module "mongodb" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/mongodb?ref=v0.2.0"

  set = {
    "architecture"          = "replicaset",
    "replicaCount"          = "3",
    "persistence.enabled"   = "true",
    "persistence.size"      = "100Gi",
    "podAntiAffinityPreset" = "hard",
    "pdb.create"            = "true",
    "pdb.minAvailable"      = "1",
  }
}
