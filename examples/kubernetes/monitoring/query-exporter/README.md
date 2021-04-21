# Simple query-exporter installation

The module checks for the existence of the file values.aml and its content.

If there is no file or it is empty, then uses default values.yaml from the module.

```
module "query_exporter" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/query-exporter?ref=v0.1.0"

  set = {}

  set_sensitive = {
    "secrets.DB_CONNECTION_STRING" = var.db_dsn
  }
}
```

## Terraform plan

```
var.db_dsn
  DB_CONNECTION_STRING

  Enter a value: postgresql://postgres:password@host:port/database


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.query_exporter.helm_release.this will be created
  + resource "helm_release" "this" {
      + atomic                     = false
      + chart                      = "query-exporter"
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
      + name                       = "query-exporter"
      + namespace                  = "monitoring"
      + recreate_pods              = false
      + render_subchart_notes      = true
      + replace                    = false
      + repository                 = "https://makezbs.github.io/helm-charts"
      + reset_values               = false
      + reuse_values               = false
      + skip_crds                  = false
      + status                     = "deployed"
      + timeout                    = 300
      + values                     = [
          + <<-EOT
                exporter_config: |
                  databases:
                    db1:
                      dsn: env:DB_CONNECTION_STRING
                
                  metrics:
                    metrics1:
                      type: gauge
                      description: Blocks count
                
                  queries:
                    query1:
                      interval: 5
                      databases: [db1]
                      metrics: [metric1]
                      sql: SELECT random() / 1000000000000000 AS metric1
            EOT,
        ]
      + verify                     = false
      + version                    = "0.1.0"
      + wait                       = true

      + set {
          + name  = "fullnameOverride"
          + value = "query-exporter"
        }
      + set {
          + name  = "resources.limits.memory"
          + value = "256Mi"
        }
      + set {
          + name  = "resources.requests.cpu"
          + value = "50m"
        }
      + set {
          + name  = "resources.requests.memory"
          + value = "128Mi"
        }

      + set_sensitive {
          + name  = "example_db_connection_string"
          + value = (sensitive value)
        }
      + set_sensitive {
          + name  = "secrets.DB_CONNECTION_STRING"
          + value = (sensitive value)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_query_exporter"></a> [query\_exporter](#module\_query\_exporter) | git::https://github.com/makezbs/toolbox.git//modules/query-exporter?ref=v0.1.0 |  |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.1/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. | `string` | `"query-exporter"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `"0.1.0"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | (Optional) Create the namespace if it does not yet exist. Defaults to true | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Release name | `string` | `"query-exporter"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace to install the release into. Defaults to default. | `string` | `"monitoring"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://makezbs.github.io/helm-charts"` | no |
| <a name="input_set"></a> [set](#input\_set) | (Optional) Value blocks with custom values to be merged with the values yaml. | `map(string)` | `{}` | no |
| <a name="input_set_sensitive"></a> [set\_sensitive](#input\_set\_sensitive) | (Optional) Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | `map(string)` | `{}` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `string` | `"values.yaml"` | no |
| <a name="input_db_dsn"></a> [db\_dsn](#input\_db\_dsn) | DB\_CONNECTION\_STRING | `string` | n/a | yes |

## Outputs

No outputs.
