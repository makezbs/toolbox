module "vault" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/vault?ref=v0.1.0"

  name      = basename(path.cwd)
  namespace = "utils"

  set = {
    "injector.enabled"    = "true",
    "dataStorage.enabled" = "true",
    "dataStorage.size"    = "10Gi",
  }
}
