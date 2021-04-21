# Simple Grafana loki-stack installation to DigitalOcean

## Note: Tested only with AWS S3 bucket and DigitalOcean S3 bucket

The module checks for the existence of the file values.aml and its content.

If there is no file or it is empty, then uses default values.yaml from the module.

```
module "loki_stack" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/loki-stack?ref=v0.1.0"

  set = {
    "promtail.enabled"         = "true",
    "loki.persistence.enabled" = "false",
  }

  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
}
```

## Terraform plan

```
var.aws_access_key_id
  AWS Access Key ID

  Enter a value: 123

var.aws_secret_access_key
  AWS secret access key

  Enter a value: 123


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.loki_stack.helm_release.this will be created
  + resource "helm_release" "this" {
      + atomic                     = false
      + chart                      = "loki-stack"
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
      + name                       = "loki-stack"
      + namespace                  = "monitoring"
      + recreate_pods              = false
      + render_subchart_notes      = true
      + replace                    = false
      + repository                 = "https://grafana.github.io/helm-charts"
      + reset_values               = false
      + reuse_values               = false
      + skip_crds                  = false
      + status                     = "deployed"
      + timeout                    = 300
      + values                     = [
          + <<-EOT
                loki:
                  env:
                    - name: AWS_ACCESS_KEY_ID
                      valueFrom:
                        secretKeyRef:
                          name: loki-aws-credentials
                          key: aws_access_key_id
                    - name: AWS_SECRET_ACCESS_KEY
                      valueFrom:
                        secretKeyRef:
                          name: loki-aws-credentials
                          key: aws_secret_access_key
                
                  config:
                    schema_config:
                      configs:
                        - from: 2021-01-01
                          store: boltdb-shipper
                          object_store: aws
                          schema: v11
                          index:
                            prefix: index_
                            period: 24h
                    server:
                      http_listen_port: 3100
                    storage_config:
                      aws:
                        endpoint: fra1.digitaloceanspaces.com
                        s3: s3://fra1/logs-example-com
                      boltdb_shipper:
                        active_index_directory: /data/loki/index
                        cache_location: /data/loki/boltdb-cache
                        cache_ttl: 24h # Can be increased for faster performance over longer query periods, uses more disk space
                        shared_store: s3
                    chunk_store_config:
                      max_look_back_period: 720h # 30 days
                    table_manager:
                      retention_deletes_enabled: true
                      retention_period: 720h # 30 days
            EOT,
        ]
      + verify                     = false
      + version                    = "2.3.1"
      + wait                       = true

      + set {
          + name  = "filebeat.enabled"
          + value = "false"
        }
      + set {
          + name  = "fluent-bit.enabled"
          + value = "false"
        }
      + set {
          + name  = "fullnameOverride"
          + value = "loki-stack"
        }
      + set {
          + name  = "grafana.enabled"
          + value = "false"
        }
      + set {
          + name  = "logstash.enabled"
          + value = "false"
        }
      + set {
          + name  = "loki.persistence.enabled"
          + value = "false"
        }
      + set {
          + name  = "prometheus.enabled"
          + value = "false"
        }
      + set {
          + name  = "promtail.enabled"
          + value = "true"
        }
    }

  # module.loki_stack.kubernetes_secret.aws_credentials[0] will be created
  + resource "kubernetes_secret" "aws_credentials" {
      + data = (sensitive value)
      + id   = (known after apply)
      + type = "Opaque"

      + metadata {
          + generation       = (known after apply)
          + name             = "loki-aws-credentials"
          + namespace        = "monitoring"
          + resource_version = (known after apply)
          + self_link        = (known after apply)
          + uid              = (known after apply)
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.
```

## Usage

```
terraform init
terraform plan
terraform apply
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_loki_stack"></a> [loki\_stack](#module\_loki\_stack) | git::https://github.com/makezbs/toolbox.git//modules/loki-stack?ref=v0.1.0 |  |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.1/docs/resources/release) | resource |
| [kubernetes_secret.aws_credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_access_key_id"></a> [aws\_access\_key\_id](#input\_aws\_access\_key\_id) | AWS Access Key ID | `string` | n/a | yes |
| <a name="input_aws_secret_access_key"></a> [aws\_secret\_access\_key](#input\_aws\_secret\_access\_key) | AWS secret access key | `string` | n/a | yes |
| <a name="input_aws_access_key_id"></a> [aws\_access\_key\_id](#input\_aws\_access\_key\_id) | AWS Access Key ID | `string` | `""` | no |
| <a name="input_aws_secret_access_key"></a> [aws\_secret\_access\_key](#input\_aws\_secret\_access\_key) | AWS secret access key | `string` | `""` | no |
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. | `string` | `"loki-stack"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `"2.3.1"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | (Optional) Create the namespace if it does not yet exist. Defaults to true | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Release name | `string` | `"loki-stack"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace to install the release into. Defaults to default. | `string` | `"monitoring"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://grafana.github.io/helm-charts"` | no |
| <a name="input_set"></a> [set](#input\_set) | (Optional) Value blocks with custom values to be merged with the values yaml. | `map(string)` | `{}` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `string` | `"values.yaml"` | no |

## Outputs

No outputs.
