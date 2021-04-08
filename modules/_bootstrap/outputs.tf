output "helm_release" {
  value       = helm_release.this
  description = "Helm release outputs"
}

output "auth_password" {
  value       = random_password.this.result
  description = "Random password"
  sensitive   = true
}
