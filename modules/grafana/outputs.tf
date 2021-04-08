output "helm_release" {
  value       = helm_release.this
  description = "Helm release outputs"
}

output "admin_password" {
  value       = random_password.admin_password.result
  description = "Random password"
  sensitive   = true
}
