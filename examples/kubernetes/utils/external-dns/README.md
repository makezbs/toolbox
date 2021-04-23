# External-dns installation with Cloudflare

The module checks for the existence of the file values.aml and its content.

If there is no file or it is empty, then uses default values.yaml from the module.


```
module "external-dns" {
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
```

## Terraform plan
```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # cloudflare_api_token.this will be created
  + resource "cloudflare_api_token" "this" {
      + id          = (known after apply)
      + issued_on   = (known after apply)
      + modified_on = (known after apply)
      + name        = "external-dns"
      + status      = (known after apply)
      + value       = (sensitive value)

      + policy {
          + effect            = "allow"
          + permission_groups = [
              + "4755a26eedb94da69e1066d98aa820be",
              + "c8fed203ed3043cba015a93ad1616f1f",
            ]
          + resources         = {
              + "com.cloudflare.api.account.zone.eeeeeeeeeeaabbccddeeffgghhjjkk44" = "*"
            }
        }
    }

  # module.external-dns.helm_release.this will be created
  + resource "helm_release" "this" {
      + atomic                     = false
      + chart                      = "external-dns"
      + cleanup_on_fail            = false
      + create_namespace           = true
      + dependency_update          = false
      + disable_crd_hooks          = false
      + disable_openapi_validation = false
      + disable_webhooks           = false
      + force_update               = false
      + id                         = (known after apply)
      + lint                       = false
      + manifest                   = (known after apply)
      + max_history                = 0
      + metadata                   = (known after apply)
      + name                       = "external-dns"
      + namespace                  = "utils"
      + recreate_pods              = false
      + render_subchart_notes      = true
      + replace                    = false
      + repository                 = "https://charts.bitnami.com/bitnami"
      + reset_values               = false
      + reuse_values               = false
      + skip_crds                  = false
      + status                     = "deployed"
      + timeout                    = 300
      + values                     = [
          + <<-EOT
                rbac:
                  create: true
            EOT,
        ]
      + verify                     = false
      + version                    = "4.11.0"
      + wait                       = true

      + set {
          + name  = "cloudflare.email"
          + value = "user@example.com"
        }
      + set {
          + name  = "cloudflare.proxied"
          + value = "true"
        }
      + set {
          + name  = "fullnameOverride"
          + value = "external-dns"
        }
      + set {
          + name  = "policy"
          + value = "sync"
        }
      + set {
          + name  = "provider"
          + value = "cloudflare"
        }

      + set_sensitive {
          + name  = "cloudflare.apiToken"
          + value = (sensitive value)
        }
      + set_sensitive {
          + name  = "random_password"
          + value = (sensitive value)
        }
    }

  # module.external-dns.random_password.this will be created
  + resource "random_password" "this" {
      + id               = (known after apply)
      + length           = 32
      + lower            = true
      + min_lower        = 0
      + min_numeric      = 0
      + min_special      = 0
      + min_upper        = 0
      + number           = true
      + override_special = "_%@"
      + result           = (sensitive value)
      + special          = true
      + upper            = true
    }

Plan: 3 to add, 0 to change, 0 to destroy.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 2.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 2.20.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_external-dns"></a> [external-dns](#module\_external-dns) | ../../../../modules/external-dns |  |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.1/docs/resources/release) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/3.1.0/docs/resources/password) | resource |
| [cloudflare_api_token.this](https://registry.terraform.io/providers/cloudflare/cloudflare/2.20.0/docs/resources/api_token) | resource |
| [cloudflare_api_token_permission_groups.this](https://registry.terraform.io/providers/cloudflare/cloudflare/2.20.0/docs/data-sources/api_token_permission_groups) | data source |
| [cloudflare_zones.this](https://registry.terraform.io/providers/cloudflare/cloudflare/2.20.0/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. | `string` | `"external-dns"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `"4.11.0"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | (Optional) Create the namespace if it does not yet exist. Defaults to true | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Release name | `string` | `"external-dns"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace to install the release into. Defaults to default. | `string` | `"utils"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://charts.bitnami.com/bitnami"` | no |
| <a name="input_set"></a> [set](#input\_set) | (Optional) Value blocks with custom values to be merged with the values yaml. | `map(string)` | `{}` | no |
| <a name="input_set_sensitive"></a> [set\_sensitive](#input\_set\_sensitive) | (Optional) Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | `map(string)` | `{}` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `string` | `"values.yaml"` | no |

## Outputs

No outputs.
