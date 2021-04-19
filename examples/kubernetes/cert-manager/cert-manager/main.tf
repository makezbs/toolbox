module "cert-manager" {
  # source = "github.com/makezbs/toolbox/modules/cert-manager"
  source = "../../../../modules/cert-manager"

  name      = basename(path.cwd)
  namespace = "cert-manager"

  set = {
    "installCRDs" = "true",
  }
  cloudflare_api_token = cloudflare_api_token.this.value
}


data "cloudflare_api_token_permission_groups" "this" {}

resource "cloudflare_api_token" "this" {
  name = "dns_tls_edit"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.this.permissions["DNS Write"],
      data.cloudflare_api_token_permission_groups.this.permissions["Zone Read"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.*" = "*"
    }
  }
}

resource "null_resource" "cluster_issuer" {
  triggers = {
    cloudflare_api_token = cloudflare_api_token.this.value
  }

  provisioner "local-exec" {
    command = "kubectl apply -f cloudflare.yaml"
  }
}
