# Simple Hashicorp Vault installation

The module checks for the existence of the file values.aml and its content.

If there is no file or it is empty, then uses default values.yaml from the module.


```
module "vault" {
  # source = "github.com/makezbs/toolbox/modules/vault"
  source = "../../../../modules/vault"

  name      = basename(path.cwd)
  namespace = "utils"

  set = {
    "injector.enabled"    = "true",
    "dataStorage.enabled" = "true",
    "dataStorage.size"    = "10Gi",
  }
}
```

## Terraform plan

```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.vault.helm_release.this will be created
  + resource "helm_release" "this" {
      + atomic                     = false
      + chart                      = "vault"
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
      + name                       = "vault"
      + namespace                  = "utils"
      + recreate_pods              = false
      + render_subchart_notes      = true
      + replace                    = false
      + repository                 = "https://helm.releases.hashicorp.com"
      + reset_values               = false
      + reuse_values               = false
      + skip_crds                  = false
      + status                     = "deployed"
      + timeout                    = 300
      + values                     = [
          + <<-EOT
                server:
                  ingress:
                    enabled: true
                    annotations:
                      cert-manager.io/cluster-issuer: cloudflare
                      kubernetes.io/ingress.class: nginx
                      nginx.ingress.kubernetes.io/whitelist-source-range: "192.168.0.100/32"
                    hosts:
                      - host: vault.example.com
                        paths: []
                    tls:
                      - secretName: vault-example-com-tls
                        hosts:
                          - vault.example.com
                
                  standalone:
                    enabled: "-"
                    config: |
                      ui = true
                
                      listener "tcp" {
                        tls_disable = 1
                        address = "[::]:8200"
                        cluster_address = "[::]:8201"
                
                        telemetry {
                          unauthenticated_metrics_access = true
                        }
                      }
                
                      storage "file" {
                        path = "/vault/data"
                      }
                
                      telemetry {
                        prometheus_retention_time = "30s",
                        disable_hostname = true
                      }
            EOT,
        ]
      + verify                     = false
      + version                    = "0.11.0"
      + wait                       = true

      + set {
          + name  = "dataStorage.enabled"
          + value = "true"
        }
      + set {
          + name  = "dataStorage.size"
          + value = "10Gi"
        }
      + set {
          + name  = "fullnameOverride"
          + value = "vault"
        }
      + set {
          + name  = "injector.enabled"
          + value = "true"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

## Usage

```
terraform init
terraform plan
terraform apply

# Create unseal keys and root token

kubectl exec -n utils -ti sts/vault -- bash
vault operator init
vault operator unseal # and use 3 of 5 unseal keys from previouse step
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
| <a name="module_vault"></a> [vault](#module\_vault) | ../../../../modules/vault |  |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.1/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. | `string` | `"vault"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `"0.11.0"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | (Optional) Create the namespace if it does not yet exist. Defaults to true | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Release name | `string` | `"vault"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace to install the release into. Defaults to default. | `string` | `"utils"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://helm.releases.hashicorp.com"` | no |
| <a name="input_set"></a> [set](#input\_set) | (Optional) Value blocks with custom values to be merged with the values yaml. | `map(string)` | `{}` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `string` | `"values.yaml"` | no |

## Outputs

No outputs.
