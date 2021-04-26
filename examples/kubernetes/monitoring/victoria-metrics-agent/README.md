# Simple victoria-metrics-agent installation

The module checks for the existence of the file values.aml and its content.

If there is no file or it is empty, then uses default values.yaml from the module.


```
module "victoria_metrics_agent" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/victoria-metrics-agent?ref=v0.2.0"

  set = {
    "remoteWriteUrls[0]" : "http://vm-single.monitoring:8428/api/v1/write",
  }
}
```

## Terraform plan

```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.victoria_metrics_agent.helm_release.this will be created
  + resource "helm_release" "this" {
      + atomic                     = false
      + chart                      = "victoria-metrics-agent"
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
      + name                       = "victoria-metrics-agent"
      + namespace                  = "monitoring"
      + recreate_pods              = false
      + render_subchart_notes      = true
      + replace                    = false
      + repository                 = "https://victoriametrics.github.io/helm-charts/"
      + reset_values               = false
      + reuse_values               = false
      + skip_crds                  = false
      + status                     = "deployed"
      + timeout                    = 300
      + values                     = [
          + <<-EOT
                config:
                  global:
                    scrape_interval: 10s
                
                  scrape_configs:
                    - job_name: node-exporter
                      static_configs:
                        - targets: ["node-exporter:9100"]
                    - job_name: kube-state-metrics
                      static_configs:
                        - targets: ["kube-state-metrics:8080"]
            EOT,
        ]
      + verify                     = false
      + version                    = "0.7.15"
      + wait                       = true

      + set {
          + name  = "rbac.create"
          + value = "true"
        }
      + set {
          + name  = "rbac.pspEnabled"
          + value = "true"
        }
      + set {
          + name  = "remoteWriteUrls[0]"
          + value = "http://vm-single.monitoring:8428/api/v1/write"
        }
      + set {
          + name  = "resources.limits.memory"
          + value = "2048Mi"
        }
      + set {
          + name  = "resources.requests.cpu"
          + value = "200"
        }
      + set {
          + name  = "resources.requests.memory"
          + value = "512Mi"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
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

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_victoria_metrics_agent"></a> [victoria\_metrics\_agent](#module\_victoria\_metrics\_agent) | git::https://github.com/makezbs/toolbox.git//modules/victoria-metrics-agent?ref=v0.2.0 |  |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.1/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. | `string` | `"victoria-metrics-agent"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `"0.7.15"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | (Optional) Create the namespace if it does not yet exist. Defaults to true | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Release name | `string` | `"victoria-metrics-agent"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace to install the release into. Defaults to default. | `string` | `"monitoring"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://victoriametrics.github.io/helm-charts/"` | no |
| <a name="input_set"></a> [set](#input\_set) | (Optional) Value blocks with custom values to be merged with the values yaml. | `map(string)` | `{}` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `string` | `"values.yaml"` | no |

## Outputs

No outputs.
