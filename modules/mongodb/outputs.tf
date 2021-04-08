output "root_password" {
  value       = random_password.root_password.result
  description = "MongoDB(R) root password"
  sensitive   = true
}

output "user_password" {
  value       = random_password.user_password.result
  description = "MongoDB(R) custom user password"
  sensitive   = true
}

output "replica_set_key" {
  value       = random_password.replica_set_key.result
  description = "Key used for replica set authentication"
  sensitive   = true
}
