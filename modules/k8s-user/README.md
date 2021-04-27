## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.1.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.1.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.1.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_certificate_signing_request.this](https://registry.terraform.io/providers/hashicorp/kubernetes/2.1.0/docs/resources/certificate_signing_request) | resource |
| [kubernetes_cluster_role_binding.this](https://registry.terraform.io/providers/hashicorp/kubernetes/2.1.0/docs/resources/cluster_role_binding) | resource |
| [kubernetes_secret.this](https://registry.terraform.io/providers/hashicorp/kubernetes/2.1.0/docs/resources/secret) | resource |
| [local_file.this](https://registry.terraform.io/providers/hashicorp/local/2.1.0/docs/resources/file) | resource |
| [tls_cert_request.this](https://registry.terraform.io/providers/hashicorp/tls/3.1.0/docs/resources/cert_request) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/3.1.0/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#input\_cluster\_ca\_certificate) | Kubernetes cluster CA certificate | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | `"my-awesome-cluster"` | no |
| <a name="input_kubernetes_server_url"></a> [kubernetes\_server\_url](#input\_kubernetes\_server\_url) | Kubernetes server URL | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Username | `string` | n/a | yes |
| <a name="input_role_ref"></a> [role\_ref](#input\_role\_ref) | (Required) The ClusterRole to bind Subjects to. | `list(map(string))` | n/a | yes |
| <a name="input_subject"></a> [subject](#input\_subject) | (Required) The Users, Groups, or ServiceAccounts to grant permissions to | `list(map(string))` | n/a | yes |

## Outputs

No outputs.
