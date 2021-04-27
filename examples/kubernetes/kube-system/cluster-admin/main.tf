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
