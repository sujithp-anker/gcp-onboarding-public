provider "google" {
  region = "asia-south-1"
}

module "notification-channel" {
  source = "./modules/notification-channel"
  display-name = var.display_name
  email-address = var.email_address
}

module "snapshot-schedule" {
  source = "./modules/snapshot-schedule"
  days_in_cycle = var.days_in_cycle
  start_time = var.start_time
  retention_days = var.retention_days
  
}