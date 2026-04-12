provider "google" {
    project = "ankercloud-testing-account"
    region = "asia-south1"
}

resource "google_compute_resource_policy" "snapshot_schedule" {
    name = "snapshot-policy-vm"
    snapshot_schedule_policy {
      schedule {
        daily_schedule {
          days_in_cycle = var.days_in_cycle
          start_time = var.start_time
        }
      }
      retention_policy {
        max_retention_days = var.retention_days
      }
    }

}