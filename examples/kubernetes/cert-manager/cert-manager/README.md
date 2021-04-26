# Simple cert-manager installation with Cloudflare

The module checks for the existence of the file values.aml and its content.

If there is no file or it is empty, then uses default values.yaml from the module.

At the moment works and tested only with Cloudflare

```
module "cert-manager" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/cert-manager?ref=v0.2.0"

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
      + name        = "dns_tls_edit"
      + status      = (known after apply)
      + value       = (sensitive value)

      + policy {
          + effect            = "allow"
          + permission_groups = [
              + "4755a26eedb94da69e1066d98aa820be",
              + "c8fed203ed3043cba015a93ad1616f1f",
            ]
          + resources         = {
              + "com.cloudflare.api.account.zone.*" = "*"
            }
        }
    }

  # null_resource.cluster_issuer will be created
  + resource "null_resource" "cluster_issuer" {
      + id       = (known after apply)
      + triggers = (known after apply)
    }

  # module.cert-manager.helm_release.this will be created
  + resource "helm_release" "this" {
      + atomic                     = false
      + chart                      = "cert-manager"
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
      + name                       = "cert-manager"
      + namespace                  = "cert-manager"
      + recreate_pods              = false
      + render_subchart_notes      = true
      + replace                    = false
      + repository                 = "https://charts.jetstack.io"
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
      + version                    = "v1.3.1"
      + wait                       = true

      + set {
          + name  = "fullnameOverride"
          + value = "cert-manager"
        }
      + set {
          + name  = "installCRDs"
          + value = "true"
        }
    }

Plan: 3 to add, 0 to change, 0 to destroy.

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.1 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 2.20.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.1.0 |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 2.20.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cert-manager"></a> [cert-manager](#module\_cert-manager) | git::https://github.com/makezbs/toolbox.git//modules/cert-manager?ref=v0.2.0 |  |

## Resources

| Name | Type |
|------|------|
| [cloudflare_api_token.this](https://registry.terraform.io/providers/cloudflare/cloudflare/2.20.0/docs/resources/api_token) | resource |
| [null_resource.cluster_issuer](https://registry.terraform.io/providers/hashicorp/null/3.1.0/docs/resources/resource) | resource |
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.1/docs/resources/release) | resource |
| [kubernetes_secret.cf_api_key](https://registry.terraform.io/providers/hashicorp/kubernetes/2.1.0/docs/resources/secret) | resource |
| [cloudflare_api_token_permission_groups.this](https://registry.terraform.io/providers/cloudflare/cloudflare/2.20.0/docs/data-sources/api_token_permission_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. | `string` | `"cert-manager"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `"v1.3.1"` | no |
| <a name="input_cloudflare_api_token"></a> [cloudflare\_api\_token](#input\_cloudflare\_api\_token) | Cloudflare API token to work with DNS and Zone | `string` | `""` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | (Optional) Create the namespace if it does not yet exist. Defaults to true | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Release name | `string` | `"cert-manager"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace to install the release into. Defaults to default. | `string` | `"cert-manager"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://charts.jetstack.io"` | no |
| <a name="input_set"></a> [set](#input\_set) | (Optional) Value blocks with custom values to be merged with the values yaml. | `map(string)` | `{}` | no |
| <a name="input_set_sensitive"></a> [set\_sensitive](#input\_set\_sensitive) | (Optional) Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | `map(string)` | `{}` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `string` | `"values.yaml"` | no |


## Outputs

No outputs.
