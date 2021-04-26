module "query_exporter" {
  source = "git::https://github.com/makezbs/toolbox.git//modules/query-exporter?ref=v0.2.0"

  set = {}

  set_sensitive = {
    "secrets.DB_CONNECTION_STRING" = var.db_dsn
  }
}
