module "query_exporter" {
  # source = "github.com/makezbs/toolbox/modules/query-exporter"
  source = "../../../../modules/query-exporter"

  set = {}

  set_sensitive = {
    "secrets.DB_CONNECTION_STRING" = var.db_dsn
  }
}
