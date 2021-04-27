variable "name" {
  type        = string
  description = "Username"
}

variable "cluster_ca_certificate" {
  type        = string
  description = "Kubernetes cluster CA certificate"
}

variable "subject" {
  type = list(map(string))
  description = "(Required) The Users, Groups, or ServiceAccounts to grant permissions to"
}

variable "role_ref" {
  type = list(map(string))
  description = "(Required) The ClusterRole to bind Subjects to. "
}

variable "kubernetes_server_url" {
  type        = string
  description = "Kubernetes server URL"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name"
  default     = "my-awesome-cluster"
}
