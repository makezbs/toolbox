module "vault" {
  # source = "github.com/makezbs/toolbox/modules/vault"
  source = "../../../../modules/vault"

  name      = basename(path.cwd)
  namespace = "utils"

  set = {
    "injector.enabled"    = "true",
    "dataStorage.enabled" = "true",
    "dataStorage.size"    = "10Gi",
  }
}
