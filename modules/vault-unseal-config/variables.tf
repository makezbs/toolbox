variable "name" {
  type        = string
  default     = "autounseal"
  description = "(Required) The name of the policy"
}

variable "policy" {
  type        = string
  description = "(Required) String containing a Vault policy"
  default     = <<-EOF
   path "transit/encrypt/autounseal" {
     capabilities = [ "update" ]
   }
   path "transit/decrypt/autounseal" {
     capabilities = [ "update" ]
   }
  EOF
}

variable "default_lease_ttl_seconds" {
  type        = number
  default     = 0
  description = "(Optional) Default lease duration for tokens and secrets in seconds"
}

variable "max_lease_ttl_seconds" {
  type        = number
  default     = 0
  description = "(Optional) Maximum possible lease duration for tokens and secrets in seconds"
}

variable "namespace" {
  type        = string
  default     = "default"
  description = "(Optional) Namespace defines the space within which name of the secret must be unique."
}

variable "use_kubernetes" {
  type        = bool
  default     = false
  description = "(Optional) Handler to use kubernetes and create secret with VAULT_TOKEN"
}

variable "class" {
  type        = string
  default     = "primary"
  description = "(Optional k8s only) Handler to set class of installation if use two vault in one namespace/cluster"
}

variable "token_ttl" {
  type        = number
  default     = 0
  description = "(Optional) The TTL period of this token"
}

variable "token_renew_min_lease" {
  type        = number
  default     = 0
  description = "(Optional) The minimal lease to renew this token"
}

variable "token_renew_increment" {
  type        = number
  default     = 0
  description = "(Optional) The renew increment"
}

variable "token_num_uses" {
  type        = number
  default     = 0
  description = "(Optional) The number of allowed uses of this token"
}

variable "token_renewable" {
  type        = bool
  default     = true
  description = "(Optional) Flag to allow to renew this token"
}
