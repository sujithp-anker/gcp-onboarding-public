locals {
  retention_days = var.environment == "Prod" ? 30 : 7 
}

resource "google_compute_resource_policy" "snapshot_schedule" {
  name    = "ankercloud-snapshot-policy"
  project = var.project_id

  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "03:00"
      }
    }
    retention_policy {
      max_retention_days    = local.retention_days
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
    snapshot_properties {
      storage_locations = [var.region]
      guest_flush       = false
    }
  }
}