## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.7 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.7 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | ~> 3.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_secret.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [vault_audit.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/audit) | resource |
| [vault_mount.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_token.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/token) | resource |
| [vault_transit_secret_backend_key.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/transit_secret_backend_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_class"></a> [class](#input\_class) | (Optional k8s only) Handler to set class of installation if use two vault in one namespace/cluster | `string` | `"primary"` | no |
| <a name="input_default_lease_ttl_seconds"></a> [default\_lease\_ttl\_seconds](#input\_default\_lease\_ttl\_seconds) | (Optional) Default lease duration for tokens and secrets in seconds | `number` | `0` | no |
| <a name="input_max_lease_ttl_seconds"></a> [max\_lease\_ttl\_seconds](#input\_max\_lease\_ttl\_seconds) | (Optional) Maximum possible lease duration for tokens and secrets in seconds | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the policy | `string` | `"autounseal"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) Namespace defines the space within which name of the secret must be unique. | `string` | `"default"` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | (Required) String containing a Vault policy | `string` | `"path \"transit/encrypt/autounseal\" {\n  capabilities = [ \"update\" ]\n}\npath \"transit/decrypt/autounseal\" {\n  capabilities = [ \"update\" ]\n}\n"` | no |
| <a name="input_token_num_uses"></a> [token\_num\_uses](#input\_token\_num\_uses) | (Optional) The number of allowed uses of this token | `number` | `0` | no |
| <a name="input_token_renew_increment"></a> [token\_renew\_increment](#input\_token\_renew\_increment) | (Optional) The renew increment | `number` | `0` | no |
| <a name="input_token_renew_min_lease"></a> [token\_renew\_min\_lease](#input\_token\_renew\_min\_lease) | (Optional) The minimal lease to renew this token | `number` | `0` | no |
| <a name="input_token_renewable"></a> [token\_renewable](#input\_token\_renewable) | (Optional) Flag to allow to renew this token | `bool` | `true` | no |
| <a name="input_token_ttl"></a> [token\_ttl](#input\_token\_ttl) | (Optional) The TTL period of this token | `number` | `0` | no |
| <a name="input_use_kubernetes"></a> [use\_kubernetes](#input\_use\_kubernetes) | (Optional) Handler to use kubernetes and create secret with VAULT\_TOKEN | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autounseal_token"></a> [autounseal\_token](#output\_autounseal\_token) | Vault token with autounseal permissions |
