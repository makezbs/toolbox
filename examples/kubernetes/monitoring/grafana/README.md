# Simple grafana installation

The module checks for the existence of the file values.aml and its content.

If there is no file or it is empty, then uses default values.yaml from the module.

```
variable "smtp_password" {
  type        = string
  description = "SMTP Password"
}

module "grafana" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/grafana?ref=v0.2.0"

  set = {
    "plugins[0]"                                           = "redis-datasource",
    "plugins[1]"                                           = "grafana-piechart-panel",
    "grafana\\.ini.server.root_url"                        = "https://grafana.example.com"
    "grafana\\.ini.smtp.enable"                            = "true",
    "grafana\\.ini.smtp.host"                              = "smtp.sendgrid.net:465",
    "grafana\\.ini.smtp.user"                              = "apikey",
    "grafana\\.ini.smtp.from_address"                      = "grafana-admin@example.com",
    "grafana\\.ini.smtp.from_name"                         = "Grafana Admin"
    "ingress.enabled"                                      = "true",
    "ingress.annotations.kubernetes\\.io/ingress\\.class"  = "nginx",
    "ingress.annotations.cert-manager\\.io/cluster-issuer" = "letsencrypt"
    "ingress.hosts[0]"                                     = "grafana.example.com"
    "ingress.path"                                         = "/"
    "ingress.tls[0].secretName"                            = "grafana-example-tls"
    "ingress.tls[0].hosts[0]"                              = "grafana.example.com"
  }

  set_sensitive = {
    "grafana\\.ini.smtp.password" = var.smtp_password
  }
}
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
| <a name="module_grafana"></a> [grafana](#module\_grafana) | git::https://github.com/makezbs/toolbox.git//modules/grafana?ref=v0.2.0 |  |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.1/docs/resources/release) | resource |
| [random_password.admin_password](https://registry.terraform.io/providers/hashicorp/random/3.1.0/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. | `string` | `"grafana"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `"6.7.3"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | (Optional) Create the namespace if it does not yet exist. Defaults to true | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Release name | `string` | `"grafana"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace to install the release into. Defaults to default. | `string` | `"monitoring"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://grafana.github.io/helm-charts"` | no |
| <a name="input_set"></a> [set](#input\_set) | (Optional) Value blocks with custom values to be merged with the values yaml. | `map(string)` | `{}` | no |
| <a name="input_set_sensitive"></a> [set\_sensitive](#input\_set\_sensitive) | (Optional) Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | `map(string)` | `{}` | no |
| <a name="input_smtp_password"></a> [smtp\_password](#input\_smtp\_password) | SMTP Password | `string` | n/a | yes |

## Outputs

No outputs.
