output "autounseal_token" {
  value       = vault_token.this.client_token
  description = "Vault token with autounseal permissions"
}
