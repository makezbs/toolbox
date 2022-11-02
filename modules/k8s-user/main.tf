resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_cert_request" "this" {
  private_key_pem = tls_private_key.this.private_key_pem

  subject {
    common_name  = var.name
    organization = "developer"
  }
}

resource "kubernetes_certificate_signing_request_v1" "this" {
  metadata {
    name = var.name
  }
  spec {
    usages = [
      "digital signature",
      "key encipherment",
      "client auth"
    ]
    request     = tls_cert_request.this.cert_request_pem
    signer_name = "kubernetes.io/kube-apiserver-client"
  }
  auto_approve = true
}

resource "kubernetes_secret_v1" "this" {
  metadata {
    name = var.name
  }
  data = {
    "tls.crt" = kubernetes_certificate_signing_request_v1.this.certificate
    "tls.key" = tls_private_key.this.private_key_pem
  }
  type = "kubernetes.io/tls"
}


resource "kubernetes_service_account_v1" "this" {
  metadata {
    name = var.name
  }
}

resource "kubernetes_cluster_role_binding_v1" "this" {
  metadata {
    name = var.name
  }

  # TODO: Use Dynamic map (not list(map(string)))
  dynamic "role_ref" {
    for_each = var.role_ref

    content {
      kind      = role_ref.value["kind"]
      name      = role_ref.value["name"]
      api_group = role_ref.value["api_group"]
    }
  }

  # TODO: Add opportunity to use other keys like `namespace`
  dynamic "subject" {
    for_each = var.subject

    content {
      kind      = subject.value["kind"]
      name      = subject.value["name"]
      api_group = subject.value["api_group"]
    }
  }
  # TODO: Rewrite this part
  subject {
    kind = "ServiceAccount"
    name = var.name
  }
}

resource "local_file" "kube_config" {
  content = templatefile(
    join("/", [path.module, "templates/kubeconfig.tmpl"]), {
      cluster_ca_certificate = base64encode(var.cluster_ca_certificate)
      client_certificate     = base64encode(kubernetes_certificate_signing_request_v1.this.certificate)
      client_key             = base64encode(tls_private_key.this.private_key_pem)
      client_token           = data.kubernetes_secret_v1.this.data.token
      name                   = var.name
      cluster_name           = var.cluster_name
      server                 = var.kubernetes_server_url

    }
  )
  filename = join("/", [path.cwd, ".kube", "config.yaml"])

  depends_on = [kubernetes_secret_v1.this]
}

data "kubernetes_secret_v1" "this" {
  metadata {
    name = kubernetes_service_account_v1.this.default_secret_name
  }
  depends_on = [kubernetes_service_account_v1.this]
}

resource "local_file" "token" {
  content  = data.kubernetes_secret_v1.this.data.token
  filename = join("/", [path.cwd, ".kube", "token"])
}
