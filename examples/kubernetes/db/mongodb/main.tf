module "mongodb" {
  source = "../../../../modules/mongodb/"

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
