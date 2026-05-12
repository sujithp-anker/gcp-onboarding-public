
variable "Customer_Name" {
  type        = string
  description = "The name of the client (e.g., 'AcmeCorp'). Used to name all new resources."
}

variable "Project_Id" {
  type        = string
  description = "Project ID of the customer account."
}

# variable "Display_name" {
#   type        = string
#   description = "Display name for alerts-notification"
#   default     = ""
# }

variable "Region" { 
  type        = string
  default     = ""
  description = "The GCP Region where the servers and databases are located."
}

variable "Environment" {
  type        = string
  default     = "Stage"
  description = "Set to 'Prod' (30-day retention) or 'Stage' (7-day retention). Applies "
}

variable "Enable_Monitoring" {
  type        = bool
  default     = true
  description = "Turn OFF (false) to stop alerts and emails."
}

variable "Alert_Emails" {
  description = "List of email addresses to receive alerts."
  type    = string
  default = ""
}

variable "Enable_Snapshot_Schedule" {
  type        = bool
  default     = false
  description = "If true, enables automated daily snapshots for VM disks. Retention will be set based on Environment."
}

variable "Enable_IAM_Policy_Change_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for IAM policy modification"
}

variable "Enable_Firewall_Events_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for modifying firewall"
}

variable "Enable_Instance_Delete_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for instance deletion"
}

variable "Enable_Instance_Insert_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for instance creation"
}

variable "Enable_Label_Modification_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for label modification"
}

variable "Enable_Service_Account_Creation_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for service account creation"
}

variable "Enable_Disk_Deletion_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for disk deletion"
}

variable "Enable_Service_Account_Key_Deletion_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for service account key deletion"
}

variable "Enable_VM_Utilization_Alerts" {
  type        = bool
  default     = false
  description = "Enables CPU, Memory, and Disk alerts for VMs labeled with 'monitoring=true'."
}

variable "Enable_CloudSQL_Utilization_Alerts" {
  type        = bool
  default     = false
  description = "Enables CPU, Memory, Disk, Connections, and Lag alerts for Cloud SQL instances labeled with 'monitoring=true'."
}

# variable "iam_user" {
#   type        = string
#   description = "IAM user to attach the custom role"
# }

# variable "create_custom_roles" {
#   type        = bool
#   default     = true
#   description = "Least-priviledge role"
# }

# variable "enable_viewer_role" {
#   type        = bool
#   default     = true
#   description = "Viewer role"
# }

variable "Create_Least_Privele_User" {
  type = object({
    user                = string
    create_custom_roles = optional(bool, true)
    enable_viewer_role  = optional(bool, true)
  })
  description = "IAM user and role configuration for onboarding."
}

variable "health_check_name" {
  type        = string
  description = "Name of the load balancer health check"
}

variable "check_interval_sec" {
  type        = number
  description = "Time between each health check"
}

variable "port" {
  type        = number
  description = "Port used by the health check to connect to the backend service"
}

variable "request_path" {
  type        = string
  description = "HTTP request path used for the health check"
}

variable "timeout_sec" {
  type        = number
  description = "Time in seconds to wait for a health check response before marking it failed"
}

variable "healthy_threshold" {
  type        = number
  description = "Number of consecutive successful health checks required to mark the backend healthy"
}

variable "unhealthy_threshold" {
  type        = number
  description = "Number of consecutive failed health checks required to mark the backend unhealthy"
}

variable "security_policy_name" {
  type        = string
  description = "Backend security policy or Edge securit policy"
}

variable "rule_priority" {
  type        = number
  default     = 1000
  description = "Priority of the Cloudarmor rule"
}

variable "rule_action" {
  type    = string
  default = "deny(403)"
}

variable "src_ip_ranges" {
  type = list(string)
}

variable "default_rule_action" {
  type    = string
  default = "deny"
}

variable "enable_gke_node_cpu_80_alert" {
  type    = bool
  default = false
}

variable "enable_gke_node_memory_80_alert" {
  type    = bool
  default = false
}

variable "enable_gke_node_disk_80_alert" {
  type    = bool
  default = false
}

variable "enable_gke_crashloopbackoff_alert" {
  type    = bool
  default = false
}

variable "enable_gke_pending_pods_alert" {
  type    = bool
  default = false
}

variable "enable_gke_cluster_cpu_memory_saturation_alert" {
  type    = bool
  default = false
}

variable "enable_gke_backup_failure_alert" {
  type    = bool
  default = false
}

variable "enable_gke_backup_plan" {
  type    = bool
  default = false
}

variable "gke_backup_plan_name" {
  type        = string
  description = "Backup Plan for GKE"
}

variable "gke_cluster_id" {
  type = string
}

variable "gke_backup_region" {
  type = string
}

variable "gke_backup_retention_days" {
  type    = number
  default = 7
}

variable "gke_backup_cron_schedule" {
  type    = string
  default = "0 1 * * *"
}

variable "enable_budget_alert" {
  type    = bool
  default = false
}

variable "billing_account_id" {
  type = string
}

variable "budget_name" {
  type = string
}

variable "project_number" {
  type = string
}

variable "budget_amount" {
  type = number
}

variable "function_name" {
  type        = string
  description = "Cloud Function used for automatic resource labeling"
}

variable "pubsub_topic_name" {
  type        = string
  description = "Pub/Sub topic used to receive resource change events"
}

variable "asset_feed_name" {
  type        = string
  description = "Cloud Asset Inventory service feed used to monitor resource events"
}

variable "labels_to_apply" {
  type        = map(string)
  description = "Labels to attach automatically to newly created resources such as VMs, Cloud SQL instances, buckets, and Cloud Run services"
}