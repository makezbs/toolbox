module "external_dns" {
  source = "../../../../modules/external-dns"

  name      = basename(path.cwd)
  namespace = "utils"

  set = {
    "provider"           = "cloudflare",
    "cloudflare.email"   = "user@example.com",
    "cloudflare.proxied" = "true",
    "policy"             = "sync",
  }

  set_sensitive = {
    "cloudflare.apiToken" = cloudflare_api_token.this.value
  }
}


data "cloudflare_api_token_permission_groups" "this" {}

data "cloudflare_zones" "this" {
  filter {
    name = "example.com"
  }
}

resource "cloudflare_api_token" "this" {
  name = basename(path.cwd)

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.this.permissions["DNS Write"],
      data.cloudflare_api_token_permission_groups.this.permissions["Zone Read"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.${data.cloudflare_zones.this.zones[0].id}" = "*"
    }
  }
}
