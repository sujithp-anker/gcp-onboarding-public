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

 module "cpu_alerts" {
  source = "./modules/alerts"

  notification_channel_id = module.notification_channel.notification_channel_id

  enable_cpu_80_alert = var.enable_cpu_80_alert
  enable_cpu_90_alert = var.enable_cpu_90_alert
}

module "ops_agent" {
  source = "./modules/ops_agent"
  count = var.enable_ops_agent ? 1 : 0
}

module "vpc_flowlogs" {

  source = "./modules/vpc_flowlogs"

  subnet_name          = var.subnet_name
  region               = var.region
  network              = var.network
  ip_cidr_range        = var.ip_cidr_range

  enable_vpc_flow_logs = var.enable_vpc_flow_logs
}