resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_cert_request" "this" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.this.private_key_pem

  subject {
    common_name  = var.name
    organization = "developer"
  }
}

resource "kubernetes_certificate_signing_request" "this" {
  metadata {
    name = var.name
  }
  spec {
    usages = [
      "digital signature",
      "key encipherment",
      "client auth",
      "server auth"
    ]
    request = tls_cert_request.this.cert_request_pem
  }
  auto_approve = true
}


resource "kubernetes_secret" "this" {
  metadata {
    name = var.name
  }
  data = {
    "tls.crt" = kubernetes_certificate_signing_request.this.certificate
    "tls.key" = tls_private_key.this.private_key_pem
  }
  type = "kubernetes.io/tls"
}

resource "kubernetes_cluster_role_binding" "this" {
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
}

resource "local_file" "this" {
  content = templatefile(
    join("/", [path.module, "templates/kubeconfig.tmpl"]), {
      cluster_ca_certificate = base64encode(var.cluster_ca_certificate)
      client_certificate     = base64encode(kubernetes_certificate_signing_request.this.certificate)
      client_key             = base64encode(tls_private_key.this.private_key_pem)
      name                   = var.name
      cluster_name           = var.cluster_name
      server                 = var.kubernetes_server_url

    }
  )
  filename = join("/", [path.cwd, var.name, "kube.yaml"])
}
