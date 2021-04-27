# Creating kubernetes user using RBAC in DOKS

Module tested with DOKS (DigitalOcean Managed Kubernetes) and Self-hosted Kubernetes

```
data "digitalocean_kubernetes_cluster" "this" {
  name = "my-awesome-cluster"
}

module "user" {
  source = "../../../../modules/k8s-user"

  name                   = "cluster-admin"
  cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate)
  cluster_name           = "my-awesome-cluster"
  kubernetes_server_url  = "https://12345678-1234-1234-1234-123456789012.k8s.ondigitalocean.com"

  role_ref = [
    {
      api_group = "rbac.authorization.k8s.io"
      kind      = "ClusterRole"
      name      = "cluster-admin"
    }
  ]
  subject = [
    {
      api_group = "rbac.authorization.k8s.io"
      kind      = "User"
      name      = "cluster-admin"
    }
  ]
}
```

## Terraform plan
```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.user.kubernetes_certificate_signing_request.this will be created
  + resource "kubernetes_certificate_signing_request" "this" {
      + auto_approve = true
      + certificate  = (known after apply)
      + id           = (known after apply)

      + metadata {
          + generation       = (known after apply)
          + name             = "cluster-admin"
          + resource_version = (known after apply)
          + self_link        = (known after apply)
          + uid              = (known after apply)
        }

      + spec {
          + request = (known after apply)
          + usages  = [
              + "client auth",
              + "digital signature",
              + "key encipherment",
              + "server auth",
            ]
        }
    }

  # module.user.kubernetes_cluster_role_binding.this will be created
  + resource "kubernetes_cluster_role_binding" "this" {
      + id = (known after apply)

      + metadata {
          + generation       = (known after apply)
          + name             = "cluster-admin"
          + resource_version = (known after apply)
          + self_link        = (known after apply)
          + uid              = (known after apply)
        }

      + role_ref {
          + api_group = "rbac.authorization.k8s.io"
          + kind      = "ClusterRole"
          + name      = "cluster-admin"
        }

      + subject {
          + api_group = "rbac.authorization.k8s.io"
          + kind      = "User"
          + name      = "cluster-admin"
          + namespace = "default"
        }
    }

  # module.user.kubernetes_secret.this will be created
  + resource "kubernetes_secret" "this" {
      + data = (sensitive value)
      + id   = (known after apply)
      + type = "kubernetes.io/tls"

      + metadata {
          + generation       = (known after apply)
          + name             = "cluster-admin"
          + namespace        = "default"
          + resource_version = (known after apply)
          + self_link        = (known after apply)
          + uid              = (known after apply)
        }
    }

  # module.user.local_file.this will be created
  + resource "local_file" "this" {
      + content              = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "cluster-admin/kube.yaml"
      + id                   = (known after apply)
    }

  # module.user.tls_cert_request.this will be created
  + resource "tls_cert_request" "this" {
      + cert_request_pem = (known after apply)
      + id               = (known after apply)
      + key_algorithm    = "RSA"
      + private_key_pem  = (sensitive value)

      + subject {
          + common_name  = "cluster-admin"
          + organization = "developer"
        }
    }

  # module.user.tls_private_key.this will be created
  + resource "tls_private_key" "this" {
      + algorithm                  = "RSA"
      + ecdsa_curve                = "P224"
      + id                         = (known after apply)
      + private_key_pem            = (sensitive value)
      + public_key_fingerprint_md5 = (known after apply)
      + public_key_openssh         = (known after apply)
      + public_key_pem             = (known after apply)
      + rsa_bits                   = 4096
    }

Plan: 6 to add, 0 to change, 0 to destroy.
```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | 2.8.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.1.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.1.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.8.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.1.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_user"></a> [user](#module\_user) | ../../../../modules/k8s-user |  |

## Resources

| Name | Type |
|------|------|
| [digitalocean_kubernetes_cluster.this](https://registry.terraform.io/providers/digitalocean/digitalocean/2.8.0/docs/data-sources/kubernetes_cluster) | data source |
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
