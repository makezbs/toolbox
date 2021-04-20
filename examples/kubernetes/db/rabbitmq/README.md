# Simple Rabbitmq installation

The module checks for the existence of the file values.aml and its content.

If there is no file or it is empty, then uses default values.yaml from the module.

```
module "rabbitmq" {
  # source = "github.com/makezbs/toolbox/modules/rabbitmq"
  source = "../../../../modules/rabbitmq/"

  set = {
    "replicaCount"        = "1"
    "persistence.enabled" = "true",
    "persistence.size"    = "10Gi",
    "metrics.enabled"     = "true",
    "auth.username"       = "admin",
    "plugins"             = "rabbitmq_management rabbitmq_peer_discovery_k8s"
  }
}
```

## Terraform plan

```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.rabbitmq.helm_release.this will be created
  + resource "helm_release" "this" {
      + atomic                     = false
      + chart                      = "rabbitmq"
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
      + name                       = "rabbitmq"
      + namespace                  = "db"
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
      + version                    = "8.11.9"
      + wait                       = true

      + set {
          + name  = "auth.username"
          + value = "admin"
        }
      + set {
          + name  = "fullnameOverride"
          + value = "rabbitmq"
        }
      + set {
          + name  = "metrics.enabled"
          + value = "true"
        }
      + set {
          + name  = "persistence.enabled"
          + value = "true"
        }
      + set {
          + name  = "persistence.size"
          + value = "10Gi"
        }
      + set {
          + name  = "plugins"
          + value = "rabbitmq_management rabbitmq_peer_discovery_k8s"
        }
      + set {
          + name  = "replicaCount"
          + value = "1"
        }

      + set_sensitive {
          + name  = "auth.erlangCookie"
          + value = (sensitive value)
        }
      + set_sensitive {
          + name  = "auth.password"
          + value = (sensitive value)
        }
    }

  # module.rabbitmq.random_password.erlang_cookies will be created
  + resource "random_password" "erlang_cookies" {
      + id               = (known after apply)
      + length           = 16
      + lower            = true
      + min_lower        = 0
      + min_numeric      = 0
      + min_special      = 0
      + min_upper        = 0
      + number           = true
      + override_special = "_%@"
      + result           = (sensitive value)
      + special          = false
      + upper            = true
    }

  # module.rabbitmq.random_password.password will be created
  + resource "random_password" "password" {
      + id               = (known after apply)
      + length           = 16
      + lower            = true
      + min_lower        = 0
      + min_numeric      = 0
      + min_special      = 0
      + min_upper        = 0
      + number           = true
      + override_special = "_%@"
      + result           = (sensitive value)
      + special          = false
      + upper            = true
    }

Plan: 3 to add, 0 to change, 0 to destroy.
```

## Usage

```
terraform init
terraform plan
terraform apply

# Get Rabbitmq password
kubectl get secret -n db rabbitmq -o jsonpath="{.data.rabbitmq-password}" | base64 --decode
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rabbitmq"></a> [rabbitmq](#module\_rabbitmq) | ../../../../../modules/rabbitmq/ |  |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.1/docs/resources/release) | resource |
| [random_password.erlang_cookies](https://registry.terraform.io/providers/hashicorp/random/3.1.0/docs/resources/password) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/3.1.0/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. | `string` | `"rabbitmq"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `"8.11.9"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | (Optional) Create the namespace if it does not yet exist. Defaults to true | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Release name | `string` | `"rabbitmq"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace to install the release into. Defaults to default. | `string` | `"db"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://charts.bitnami.com/bitnami"` | no |
| <a name="input_set"></a> [set](#input\_set) | (Optional) Value blocks with custom values to be merged with the values yaml. | `map(string)` | `{}` | no |
| <a name="input_set_sensitive"></a> [set\_sensitive](#input\_set\_sensitive) | (Optional) Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | `map(string)` | `{}` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `string` | `"values.yaml"` | no |

## Outputs

No outputs.
