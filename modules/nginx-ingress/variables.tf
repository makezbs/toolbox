variable "name" {
  type        = string
  description = "Release name"
  default     = "nginx-ingress"
}

variable "namespace" {
  type        = string
  description = "(Optional) The namespace to install the release into. Defaults to default."
  default     = "kube-system"
}

variable "repository" {
  type        = string
  description = "Repository URL where to locate the requested chart."
  default     = "https://charts.bitnami.com/bitnami"
}

variable "chart" {
  type        = string
  description = "Chart name to be installed."
  default     = "nginx-ingress-controller"
}

variable "set" {
  type        = map(string)
  description = "(Optional) Value blocks with custom values to be merged with the values yaml."
  default     = {}
}

variable "set_sensitive" {
  type        = map(string)
  description = "(Optional) Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff."
  default     = {}
}

variable "chart_version" {
  type        = string
  description = "version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed."
  default     = "7.6.1"
}

variable "create_namespace" {
  type        = bool
  description = "(Optional) Create the namespace if it does not yet exist. Defaults to true"
  default     = "true"
}

variable "values_file" {
  type        = string
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
  default     = "values.yaml"
}
