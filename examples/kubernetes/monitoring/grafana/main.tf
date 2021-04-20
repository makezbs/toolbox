variable "smtp_password" {
  type        = string
  description = "SMTP Password"
}

module "grafana" {
  source = "../../../../modules/grafana/"

  set = {
    "plugins[0]"                                           = "redis-datasource",
    "plugins[1]"                                           = "grafana-piechart-panel",
    "grafana\\.ini.server.root_url"                        = "https://grafana.example.com"
    "grafana\\.ini.smtp.enable"                            = "true",
    "grafana\\.ini.smtp.host"                              = "smtp.sendgrid.net:465",
    "grafana\\.ini.smtp.user"                              = "apikey",
    "grafana\\.ini.smtp.from_address"                      = "grafana-admin@example.com",
    "grafana\\.ini.smtp.from_name"                         = "Grafana Admin"
    "ingress.enabled"                                      = "true",
    "ingress.annotations.kubernetes\\.io/ingress\\.class"  = "nginx",
    "ingress.annotations.cert-manager\\.io/cluster-issuer" = "letsencrypt"
    "ingress.hosts[0]"                                     = "grafana.example.com"
    "ingress.path"                                         = "/"
    "ingress.tls[0].secretName"                            = "grafana-example-tls"
    "ingress.tls[0].hosts[0]"                              = "grafana.example.com"
  }

  set_sensitive = {
    "grafana\\.ini.smtp.password" = var.smtp_password
  }
}
