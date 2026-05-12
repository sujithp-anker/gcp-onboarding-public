locals {
  retention_days = var.environment == "Prod" ? 35 : 7

  cluster_list = compact(split(",", replace(var.cluster_id, " ", "")))
}

resource "google_gke_backup_backup_plan" "gke_backup_plan" {
  for_each = var.enable_gke_backup_governance ? toset(local.cluster_list) : []

  name     = "${lower(var.environment)}-${element(split("/", each.value), length(split("/", each.value)) - 1)}-backup"
  cluster  = each.value
  location = var.region

  retention_policy {
    backup_retain_days = local.retention_days
  }

  backup_schedule {
    cron_schedule = "0 1 * * *"
  }

  backup_config {
    include_volume_data = true
    include_secrets     = true
    all_namespaces      = true
  }
}