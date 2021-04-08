## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 2.1 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [random_password.replica_set_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.root_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | n/a | `string` | `"mongodb"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | n/a | `string` | `"10.12.1"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | n/a | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"mongodb"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | `"db"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | n/a | `string` | `"https://charts.bitnami.com/bitnami"` | no |
| <a name="input_set"></a> [set](#input\_set) | (Optional) Value blocks with custom values to be merged with the values yaml. | `map(string)` | `{}` | no |
| <a name="input_set_sensitive"></a> [set\_sensitive](#input\_set\_sensitive) | (Optional) Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_replica_set_key"></a> [replica\_set\_key](#output\_replica\_set\_key) | n/a |
| <a name="output_root_password"></a> [root\_password](#output\_root\_password) | n/a |
| <a name="output_user_password"></a> [user\_password](#output\_user\_password) | n/a |
