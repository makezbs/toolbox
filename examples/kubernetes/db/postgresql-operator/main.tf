module "postgresql_operator" {
  source = "../../../../modules/postgres-operator/"

  name      = basename(path.cwd)
  namespace = "db"

  set = {
    "configKubernetes.pod_environment_secret"        = basename(path.cwd)
    "configAwsOrGcp.aws_region"                      = "fra1"
    "configAwsOrGcp.wal_s3_bucket"                   = "my-super-bucket-example-com"
    "configLogicalBackup.logical_backup_provider"    = "s3"
    "configLogicalBackup.logical_backup_s3_endpoint" = "https://fra1.digitaloceanspaces.com"
    "configLogicalBackup.logical_backup_s3_region"   = "fra1"
    "configLogicalBackup.logical_backup_schedule"    = "30 00 * * *"
  }

  set_sensitive = {
    "configLogicalBackup.logical_backup_s3_access_key_id"     = "my-s3-access-key-id"
    "configLogicalBackup.logical_backup_s3_secret_access_key" = "my-s3-secret-access-key"
  }
}

resource "kubernetes_secret" "this" {
  metadata {
    name      = basename(path.cwd)
    namespace = "db"
  }

  data = {
    BACKUP_SCHEDULE       = "0 */12 * * *" # Schedule a base backup every 12 hours; you can customise as you wish
    USE_WALG_BACKUP       = "true"         # Use the golang backup tool (faster)
    BACKUP_NUM_TO_RETAIN  = "1"
    AWS_ACCESS_KEY_ID     = "my-s3-access-key-id"
    AWS_SECRET_ACCESS_KEY = "my-s3-secret-access-key"
    AWS_ENDPOINT          = "https://fra1.digitaloceanspaces.com"
    AWS_REGION            = "fra1"
    WALG_DISABLE_S3_SSE   = "true" # I disable this because it's not supported by DigitalOcean
  }
}
