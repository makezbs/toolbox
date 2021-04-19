# Simple gitlab-runner installation to DigitalOcean

The module checks for the existence of the file values.aml and its content.

If there is no file or it is empty, then uses default values.yaml from the module.


```
module "nginx-ingress" {
  source = "github.com/makezbs/toolbox/modules/nginx-ingress"

  name      = basename(path.cwd)
  namespace = "kube-system"

  set = {
    "ingressClass"                    = "nginx",
    "defaultBackend.image.repository" = "jshimko/default-backend",
    "defaultBackend.image.tag"        = "1.0.0"
  }
}

```

## Terraform plan

```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.nginx-ingress.helm_release.this will be created
  + resource "helm_release" "this" {
      + atomic                     = false
      + chart                      = "nginx-ingress-controller"
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
      + name                       = "nginx-ingress"
      + namespace                  = "kube-system"
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
                fullnameOverride: nginx-ingress-controller
                kind: Deployment
                publishService:
                  enabled: "true"
                service:
                  externalTrafficPolicy: Local
                  annotations:
                    service.beta.kubernetes.io/do-loadbalancer-enable-proxy-protocol: "true"
                config:
                  use-proxy-protocol: "true"
            EOT,
        ]
      + verify                     = false
      + version                    = "7.6.1"
      + wait                       = true

      + set {
          + name  = "defaultBackend.image.repository"
          + value = "jshimko/default-backend"
        }
      + set {
          + name  = "defaultBackend.image.tag"
          + value = "1.0.0"
        }
      + set {
          + name  = "ingressClass"
          + value = "nginx"
        }
      + set {
          + name  = "kind"
          + value = "Deployment"
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
| <a name="module_nginx-ingress"></a> [nginx-ingress](#module\_nginx-ingress) | ../../../../modules/nginx-ingress |  |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.1/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. | `string` | `"nginx-ingress-controller"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `"7.6.1"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | (Optional) Create the namespace if it does not yet exist. Defaults to true | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Release name | `string` | `"nginx-ingress"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace to install the release into. Defaults to default. | `string` | `"kube-system"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://charts.bitnami.com/bitnami"` | no |
| <a name="input_set"></a> [set](#input\_set) | (Optional) Value blocks with custom values to be merged with the values yaml. | `map(string)` | `{}` | no |
| <a name="input_set_sensitive"></a> [set\_sensitive](#input\_set\_sensitive) | (Optional) Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | `map(string)` | `{}` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `string` | `"values.yaml"` | no |

## Outputs

No outputs.
