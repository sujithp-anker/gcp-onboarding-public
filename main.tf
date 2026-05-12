provider "google" {
  project = "ankercloud-testing-account"
  region  = "asia-south1"
}

module "notification_channel" {
  source = "./modules/notification_channel"

  display_name  = var.Customer_Name
  email_address = var.Alert_Emails
}

module "snapshot_schedule" {
  source      = "./modules/snapshot_schedule"
  count       = var.Enable_Snapshot_Schedule ? 1 : 0
  
  project_id  = var.Project_Id
  region      = var.Region
  environment = var.Environment
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

  project_id = var.Project_Id
  iam_user   = var.iam_user

  create_custom_roles = var.create_custom_roles

  enable_viewer_role = var.enable_viewer_role
}

module "lb_health_check" {

  source = "./modules/lb-healthcheck"

  project_id = var.Project_Id

  health_check_name = var.health_check_name

  port         = var.port
  request_path = var.request_path

  check_interval_sec = var.check_interval_sec
  timeout_sec        = var.timeout_sec

  healthy_threshold   = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold
}

module "cloudarmor_policy" {

  source = "./modules/cloudarmor-policy"

  project_id = var.Project_Id

  security_policy_name = var.security_policy_name

  rule_priority = var.rule_priority

  rule_action = var.rule_action

  src_ip_ranges = var.src_ip_ranges

  default_rule_action = var.default_rule_action
}

# root/main.tf

module "gke_alerts" {

  source = "./modules/gke-alerts"

  enable_gke_node_cpu_80_alert                   = var.enable_gke_node_cpu_80_alert
  enable_gke_node_memory_80_alert                = var.enable_gke_node_memory_80_alert
  enable_gke_node_disk_80_alert                  = var.enable_gke_node_disk_80_alert
  enable_gke_crashloopbackoff_alert              = var.enable_gke_crashloopbackoff_alert
  enable_gke_pending_pods_alert                  = var.enable_gke_pending_pods_alert
  enable_gke_cluster_cpu_memory_saturation_alert = var.enable_gke_cluster_cpu_memory_saturation_alert
  enable_gke_backup_failure_alert                = var.enable_gke_backup_failure_alert

  notification_channel_id = module.notification_channel.notification_channel_id
}

#module "gke_backup" {

#  source = "./modules/gke_backup"

#  enable_gke_backup_plan = var.enable_gke_backup_plan

#  gke_backup_plan_name = var.gke_backup_plan_name
#  gke_cluster_id       = var.gke_cluster_id
#  gke_backup_region    = var.gke_backup_region

#  gke_backup_retention_days = var.gke_backup_retention_days
#  gke_backup_cron_schedule  = var.gke_backup_cron_schedule

#}

#module "budget_alert" {

#  source = "./modules/budget-alert"

# enable_budget_alert = var.enable_budget_alert

#  billing_account_id = var.billing_account_id
# budget_name        = var.budget_name
#  project_number     = var.project_number
#  budget_amount      = var.budget_amount

#  notification_channel_id = module.notification_channel.notification_channel_id

#}

module "resource_tagging" {

  source = "./modules/resource-tagging"

  project_id = var.Project_Id

  region = var.Region

  function_name = var.function_name

  pubsub_topic_name = var.pubsub_topic_name

  asset_feed_name = var.asset_feed_name

  labels_to_apply = var.labels_to_apply
}

module "monitoring_alerts" {

  source = "./modules/monitoring-alerts"

  enable_iam_policy_change_alert = var.Enable_IAM_Policy_Change_Alerts
  enable_firewall_events_alert = var.Enable_Firewall_Events_Alerts
  enable_instance_delete_alert = var.Enable_Instance_Delete_Alerts
  enable_instance_insert_alert = var.Enable_Instance_Insert_Alerts
  enable_label_modification_alert = var.Enable_Label_Modification_Alerts
  enable_service_account_creation_alert = var.Enable_Service_Account_Creation_Alerts
  enable_disk_deletion_alert = var.Enable_Disk_Deletion_Alerts
  enable_service_account_key_deletion_alert = var.Enable_Service_Account_Key_Deletion_Alerts
  notification_channel_id = module.notification_channel.notification_channel_id
}