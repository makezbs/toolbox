# Makezbs Terraform modules collection

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

The code is provided as-is with no warranties.

## Usage

[Terraform](http://terraform.io) must be installed to use the modules.
Please refer to Terraform's [documentation](https://www.terraform.io/docs/) to get started.

Once Terraform is set up properly, you can try one of the modules:

```
|-- cert-manager
|-- gitlab-runner
|-- grafana
|-- kube-state-metrics
|-- loki-stack
|-- metrics-server
|-- mongodb
|-- nginx-ingress
|-- node-exporter
|-- query-exporter
|-- rabbitmq
|-- redis
|-- vault
|-- victoria-metrics-agent
|-- victoria-metrics-alert
|-- victoria-metrics-single
```

Simple example to setup metrics-server in you Kubernetes cluster:
```console
cd examples/kubernetes/monitoring/metrics-server
terraform init
terraform plan
terraform apply
```

## Roadmap

- [ ] Add modules for CI/CD - jenkins, argo-cd, etc
- [ ] Add native terraform modules to use Kubernetes (without helm provider)
- [ ] Add other modules to manage Hashicorp Vault, Sentry, Gitlab, etc
- [ ] Something from your Pull Requests and Issues

## License

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
[Apache 2.0 License](https://github.com/makezbs/helm-charts/blob/main/LICENSE).
