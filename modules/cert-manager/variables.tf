variable "name" {
  type        = string
  description = "Release name"
  default     = "cert-manager"
}

variable "namespace" {
  type        = string
  description = "(Optional) The namespace to install the release into. Defaults to default."
  default     = "cert-manager"
}

variable "repository" {
  type        = string
  description = "Repository URL where to locate the requested chart."
  default     = "https://charts.jetstack.io"
}

variable "chart" {
  type        = string
  description = "Chart name to be installed."
  default     = "cert-manager"
}

variable "set" {
  type        = map(string)
  description = "(Optional) Value blocks with custom values to be merged with the values yaml."
  default     = {}
}

variable "chart_version" {
  type        = string
  description = "version - (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed."
  default     = "v1.3.1"
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

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token to work with DNS and Zone"
}
