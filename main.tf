provider "google" {
  project = "ankercloud-testing-account"
  region  = "asia-south1"
}

module "notification_channel" {
  source = "./modules/notification_channel"

  display_name  = var.display_name
  email_address = var.email_address
}

# module "snapshot_schedule" {
#   source = "./modules/snapshot_schedule"

#   days_in_cycle  = var.days_in_cycle
#   start_time     = var.start_time
#   retention_days = var.retention_days
# }