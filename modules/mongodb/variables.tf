variable "name" {
  type    = string
  default = "mongodb"
}

variable "namespace" {
  type    = string
  default = "db"
}

variable "repository" {
  type    = string
  default = "https://charts.bitnami.com/bitnami"
}

variable "chart" {
  type    = string
  default = "mongodb"
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
  type = string
  default = "10.12.1"
}

variable "create_namespace" {
  type = bool
  default = "true"
}
