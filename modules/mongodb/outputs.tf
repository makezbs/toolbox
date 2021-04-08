output "root_password" {
  value     = random_password.root_password.result
  sensitive = true
}

output "user_password" {
  value     = random_password.user_password.result
  sensitive = true
}

output "replica_set_key" {
  value     = random_password.replica_set_key.result
  sensitive = true
}
