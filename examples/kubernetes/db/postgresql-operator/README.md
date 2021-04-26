# Postgresql installation with backups to DigitalOcean 

The module checks for the existence of the file values.aml and its content.

If there is no file or it is empty, then uses default values.yaml from the module.

```
module "postgresql_operator" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/postgres-operator?ref=v0.2.0"

  name      = basename(path.cwd)
  namespace = "db"

  set = {
    "configKubernetes.pod_environment_secret"        = basename(path.cwd)
    "configAwsOrGcp.aws_region"                      = "fra1"
    "configAwsOrGcp.wal_s3_bucket"                   = "my-super-bucket-example-com"
    "configLogicalBackup.logical_backup_provider"    = "s3"
    "configLogicalBackup.logical_backup_s3_endpoint" = "https://fra1.digitaloceanspaces.com"
    "configLogicalBackup.logical_backup_s3_region"   = "fra1"
    "configLogicalBackup.logical_backup_schedule"    = "30 00 * * *"
  }

  set_sensitive = {
    "configLogicalBackup.logical_backup_s3_access_key_id"     = "my-s3-access-key-id"
    "configLogicalBackup.logical_backup_s3_secret_access_key" = "my-s3-secret-access-key"
  }
}

resource "kubernetes_secret" "this" {
  metadata {
    name      = basename(path.cwd)
    namespace = "db"
  }

  data = {
    BACKUP_SCHEDULE       = "0 */12 * * *" # Schedule a base backup every 12 hours; you can customise as you wish
    USE_WALG_BACKUP       = "true"         # Use the golang backup tool (faster)
    BACKUP_NUM_TO_RETAIN  = "1"
    AWS_ACCESS_KEY_ID     = "my-s3-access-key-id"
    AWS_SECRET_ACCESS_KEY = "my-s3-secret-access-key"
    AWS_ENDPOINT          = "https://fra1.digitaloceanspaces.com"
    AWS_REGION            = "fra1"
    WALG_DISABLE_S3_SSE   = "true" # I disable this because it's not supported by DigitalOcean
  }
}
```

## Terraform plan
```

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
| <a name="module_postgresql_operator"></a> [postgresql\_operator](#module\_postgresql\_operator) | git::https://github.com/makezbs/toolbox.git//modules/postgres-operator?ref=v0.2.0 |  |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.1/docs/resources/release) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/3.1.0/docs/resources/password) | resource |
| [kubernetes_secret.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. | `string` | `"https://github.com/zalando/postgres-operator/raw/master/charts/postgres-operator/postgres-operator-1.6.2.tgz"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `""` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | (Optional) Create the namespace if it does not yet exist. Defaults to true | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Release name | `string` | `"postgres-operator"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace to install the release into. Defaults to default. | `string` | `"db"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `""` | no |
| <a name="input_set"></a> [set](#input\_set) | (Optional) Value blocks with custom values to be merged with the values yaml. | `map(string)` | `{}` | no |
| <a name="input_set_sensitive"></a> [set\_sensitive](#input\_set\_sensitive) | (Optional) Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | `map(string)` | `{}` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `string` | `"values.yaml"` | no |


## Outputs

No outputs.
