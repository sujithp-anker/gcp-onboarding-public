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

module "vm_alerts" {
  source                       = "./modules/vm-alerts"
  enable_vm_utilization_alerts = var.Enable_VM_Utilization_Alerts
  notification_channel_id      = module.notification_channel.notification_channel_id
  depends_on                   = [module.notification_channel]
}

module "cloudsql_alerts" {
  source                             = "./modules/cloudsql-alerts"
  enable_cloudsql_utilization_alerts = var.Enable_CloudSQL_Utilization_Alerts
  notification_channel_id            = module.notification_channel.notification_channel_id
  depends_on                         = [module.notification_channel]
}

module "custom_iam_role" {
  source     = "./modules/iam-least-priviledge-role"
  project_id = var.Project_Id
}

module "lb_monitoring" {
  source                  = "./modules/lb-monitoring"
  count                   = var.Enable_LB_Monitoring ? 1 : 0
  lb_names                = var.LB_Names_to_Monitor
  notification_channel_id = module.notification_channel.notification_channel_id
}

# module "cloudarmor_policy" {

#   source = "./modules/cloudarmor-policy"

#   project_id = var.Project_Id

#   security_policy_name = var.security_policy_name

#   rule_priority = var.rule_priority

#   rule_action = var.rule_action

#   src_ip_ranges = var.src_ip_ranges

#   default_rule_action = var.default_rule_action
# }

# root/main.tf

module "gke_alerts" {
  source                        = "./modules/gke-alerts"
  enable_gke_utilization_alerts = var.Enable_GKE_Utilization_Alerts
  notification_channel_id       = module.notification_channel.notification_channel_id
}

module "gke_backup" {
  source                       = "./modules/gke_backup"
  enable_gke_backup_governance = var.Enable_GKE_Backup_Governance
  cluster_id                   = var.GKE_Cluster_ID
  environment                  = var.Environment
  project_id                   = var.Project_Id
  region                       = var.Region
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

module "budget_alert" {
  source                  = "./modules/budget-alert"
  enable_budget_alert     = var.Enable_Budget_Alerts
  billing_account_id      = var.Billing_Account_ID
  project_id              = var.Project_Id
  budget_limit            = var.SET_BudgetLimit
  thresholds              = var.SET_BudgetActualThresholds
  notification_channel_id = module.notification_channel.notification_channel_id
}

# module "resource_tagging" {

#   source = "./modules/resource-tagging"

#   project_id = var.Project_Id

#   region = var.Region

#   function_name = var.function_name

#   pubsub_topic_name = var.pubsub_topic_name

#   asset_feed_name = var.asset_feed_name

#   labels_to_apply = var.labels_to_apply
# }

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