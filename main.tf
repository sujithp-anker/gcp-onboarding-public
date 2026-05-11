provider "google" {
  project = "ankercloud-testing-account"
  region  = "asia-south1"
}

module "notification_channel" {
  source = "./modules/notification_channel"

  display_name  = var.display_name
  email_address = var.email_address
}

module "snapshot_schedule" {
  source = "./modules/snapshot_schedule"

  days_in_cycle  = var.days_in_cycle
  start_time     = var.start_time
  retention_days = var.retention_days
}

module "vm-alerts" {
  source = "./modules/vm-alerts"

  notification_channel_id = module.notification_channel.notification_channel_id

  enable_vm_cpu_80_alert = var.enable_vm_cpu_80_alert
  enable_vm_cpu_90_alert = var.enable_vm_cpu_90_alert

  enable_vm_memory_80_alert = var.enable_vm_memory_80_alert
  enable_vm_memory_90_alert = var.enable_vm_memory_90_alert

  enable_vm_disk_80_alert = var.enable_vm_disk_80_alert
  enable_vm_disk_90_alert = var.enable_vm_disk_90_alert
}

module "cloudsql_alerts" {

  source = "./modules/cloudsql-alerts"

  notification_channel_id = module.notification_channel.notification_channel_id

  enable_cloudsql_cpu_80_alert = var.enable_cloudsql_cpu_80_alert
  enable_cloudsql_cpu_90_alert = var.enable_cloudsql_cpu_90_alert

  enable_cloudsql_memory_80_alert = var.enable_cloudsql_memory_80_alert
  enable_cloudsql_memory_90_alert = var.enable_cloudsql_memory_90_alert

  enable_cloudsql_disk_80_alert = var.enable_cloudsql_disk_80_alert
  enable_cloudsql_disk_90_alert = var.enable_cloudsql_disk_90_alert

  enable_cloudsql_replication_lag_alert = var.enable_cloudsql_replication_lag_alert

  enable_cloudsql_active_connections_alert = var.enable_cloudsql_active_connections_alert
}

module "custom_iam_role" {
  source = "./modules/iam-least-priviledge-role"

  project_id = var.project_id
  iam_user   = var.iam_user
}

module "lb_health_check" {

  source = "./modules/lb-healthcheck"

  project_id = var.project_id

  health_check_name = var.health_check_name

  port         = var.port
  request_path = var.request_path

  check_interval_sec  = var.check_interval_sec
  timeout_sec         = var.timeout_sec

  healthy_threshold   = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold
}
