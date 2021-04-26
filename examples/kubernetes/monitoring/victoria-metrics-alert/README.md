# Simple victoria-metrics-alert installation

The module checks for the existence of the file values.aml and its content.

If there is no file or it is empty, then uses default values.yaml from the module.

```
module "victoria_metrics_alert" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/victoria-metrics-alert?ref=v0.2.0"

  set = {
    "server.datasource.url"            = "http://victoria-metrics-single:8428",
    "server.remote.write.url"          = "http://victoria-metrics-single:8428",
    "server.remote.read.url"           = "http://victoria-metrics-single:8428",
    "server.notifier.alertmanager.url" = "http://victoria-metrics-alert-alertmanager:9093",
  }
}
```

## Terraform plan
```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.victoria_metrics_alert.helm_release.this will be created
  + resource "helm_release" "this" {
      + atomic                     = false
      + chart                      = "victoria-metrics-alert"
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
      + name                       = "victoria-metrics-alert"
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
                alertmanager:
                  enabled: true
                  retention: 120h
                  config:
                    global:
                      resolve_timeout: 60m
                    route:
                      group_by: ['job']
                      group_wait: 10s
                      group_interval: 1m
                      repeat_interval: 12h
                      receiver: 'slack'
                      routes:
                        - continue: true
                          group_wait: 10s
                          match_re:
                            channel: infra
                          receiver: slack
                    receivers:
                      - name: slack
                        slack_configs:
                          - api_url: https://hooks.slack.com/services/XXXXXXXX/XXXXXXXXXX/XXXXXXXXXXXXXXXXXXX
                            channel: alerts-dev
                            send_resolved: true
                            username: '{{ template "slack.default.username" . }}'
                            color: '{{ if eq .Status "firing" }}danger{{ else }}good{{ end }}'
                            title: '{{ template "slack.default.title" . }}'
                            title_link: '{{ template "slack.default.titlelink" . }}'
                            pretext: '{{ .CommonAnnotations.summary }}'
                            text: |-
                              {{ range .Alerts }}
                                *Alert:* {{ .Annotations.summary }} - `{{ .Labels.severity }}`
                                *Description:* {{ .Annotations.description }}
                                *Details:*
                                {{ range .Labels.SortedPairs }} • *{{ .Name }}:* `{{ .Value }}`
                                {{ end }}
                              {{ end }}
                            fallback: '{{ template "slack.default.fallback" . }}'
                            icon_emoji: '{{ template "slack.default.iconemoji" . }}'
                            icon_url: '{{ template "slack.default.iconurl" . }}'
                    templates:
                      - '/etc/alertmanager/config/*.tmpl'
                
                server:
                  config:
                    alerts:
                      groups:
                        - name: "Self monitoring"
                          rules:
                          - alert: "TargetMissing"
                            expr: "up == 0"
                            for: "0m"
                            labels:
                              severity: "critical"
                            annotations:
                              summary: "Target missing (instance {{ $labels.instance }})"
                              description: "A target has disappeared. An exporter might be crashed.\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"
            EOT,
        ]
      + verify                     = false
      + version                    = "0.3.28"
      + wait                       = true

      + set {
          + name  = "alertmanager.resources.limits.memory"
          + value = "256Mi"
        }
      + set {
          + name  = "alertmanager.resources.requests.cpu"
          + value = "100m"
        }
      + set {
          + name  = "alertmanager.resources.requests.memory"
          + value = "128Mi"
        }
      + set {
          + name  = "server.datasource.url"
          + value = "http://victoria-metrics-single:8428"
        }
      + set {
          + name  = "server.fullnameOverride"
          + value = "victoria-metrics-alert"
        }
      + set {
          + name  = "server.notifier.alertmanager.url"
          + value = "http://victoria-metrics-alert-alertmanager:9093"
        }
      + set {
          + name  = "server.remote.read.url"
          + value = "http://victoria-metrics-single:8428"
        }
      + set {
          + name  = "server.remote.write.url"
          + value = "http://victoria-metrics-single:8428"
        }
      + set {
          + name  = "server.resources.limits.memory"
          + value = "256Mi"
        }
      + set {
          + name  = "server.resources.requests.cpu"
          + value = "100m"
        }
      + set {
          + name  = "server.resources.requests.memory"
          + value = "128Mi"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
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
| <a name="module_victoria_metrics_alert"></a> [victoria\_metrics\_alert](#module\_victoria\_metrics\_alert) | git::https://github.com/makezbs/toolbox.git//modules/victoria-metrics-alert?ref=v0.2.0 |  |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.1/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. | `string` | `"victoria-metrics-alert"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `"0.3.28"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | (Optional) Create the namespace if it does not yet exist. Defaults to true | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Release name | `string` | `"victoria-metrics-alert"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace to install the release into. Defaults to default. | `string` | `"monitoring"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://victoriametrics.github.io/helm-charts/"` | no |
| <a name="input_set"></a> [set](#input\_set) | (Optional) Value blocks with custom values to be merged with the values yaml. | `map(string)` | `{}` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `string` | `"values.yaml"` | no |

## Outputs

No outputs.
