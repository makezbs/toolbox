variable "name" {
  type        = string
  description = "Deployment name"
  default     = "victoria-metrics-storage"
}

variable "service_account_name" {
  type        = string
  description = "Service account name"
  default     = "victoria-metrics-storage"
}


variable "retentionPeriod" {
  type        = number
  description = "retention period"
  default     = 1
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace for installation"
  default     = "db"
}
