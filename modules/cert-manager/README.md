## Usage

See full list of example in https://github.com/makezbs/toolbox/tree/main/examples/

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
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.1/docs/resources/release) | resource |
| [kubernetes_secret.cf_api_key](https://registry.terraform.io/providers/hashicorp/kubernetes/2.1.0/docs/resources/secret) | resource |

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
