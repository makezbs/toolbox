resource "vault_audit" "this" {
  type = "file"

  options = {
    file_path = "stdout"
  }
}

resource "vault_policy" "this" {
  name   = var.name
  policy = var.policy
}

resource "vault_mount" "this" {
  path                      = "transit"
  type                      = "transit"
  default_lease_ttl_seconds = var.default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.max_lease_ttl_seconds
}

resource "vault_transit_secret_backend_key" "this" {
  backend = vault_mount.this.path
  name    = var.name
}

resource "vault_token" "this" {
  policies = [vault_policy.this.name]

  renewable       = var.token_renewable
  ttl             = var.token_ttl
  renew_min_lease = var.token_renew_min_lease
  renew_increment = var.token_renew_increment
  num_uses        = var.token_num_uses
  no_parent       = true
}

resource "kubernetes_secret" "this" {
  count = var.use_kubernetes ? 1 : 0
  metadata {
    annotations = {}
    labels      = {}
    name        = join("-", [var.name, var.class, "token"])
    namespace   = var.namespace
  }

  data = {
    VAULT_TOKEN       = vault_token.this.client_token
    WRAPPED_TOKEN     = vault_token.this.wrapped_token
    WRAPPING_ACCESSOR = vault_token.this.wrapping_accessor
  }

  type = "Opaque"
}
