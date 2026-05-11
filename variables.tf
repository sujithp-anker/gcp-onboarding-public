
variable "project_id" {
  type = string
  description = "Enter GCP Project ID"
}

variable "Display_name" {
  type        = string
  description = "Display name for alerts-notification"
  default = ""
}

variable "Email_address" {
  type        = string
  description = "Email address for alerts notification"
}

variable "days_in_cycle" {
   type        = number
   description = "eg:1, create snapshot every 1 day"
}  

 variable "start_time" {
   type        = string 
   description = "Start time for the snapshot schedule,[24 hour format]"
 }

 variable "retention_days" {
   type        = number
   description = "Retention period for the snapshots"
 }

 variable "enable_vm_cpu_80_alert" {
  type    = bool
  default = false
  description = "Enable or disable VM CPU utilization alert policy"
 } 

variable "enable_vm_cpu_90_alert" {
  type    = bool
  default = false
  description = "Enable or disable VM CPU utilization alert policy"
}

variable "enable_vm_memory_80_alert" {
  type    = bool
  default = false
  description = "Enable or disable VM Memory utilization alert policy"
}

variable "enable_vm_memory_90_alert" {
  type    = bool
  default = false
  description = "Enable or disable VM Memory utilization alert policy"
}

variable "enable_vm_disk_80_alert" {
  type    = bool
  default = false
  description = "Enable or disable VM disk utilization alert policy"
}

variable "enable_vm_disk_90_alert" {
  type    = bool
 default = false
 description = "Enable or disable VM disk utilization alert policy"
}

variable "enable_cloudsql_cpu_80_alert" {
  type    = bool
  default = false
  description = "Enable or disable Cloudsql CPU utilization alert policy"
}

variable "enable_cloudsql_cpu_90_alert" {
  type    = bool
  default = false
  description = "Enable or disable Cloudsql CPU utilization alert policy"
}

variable "enable_cloudsql_memory_80_alert" {
  type    = bool
  default = false
  description = "Enable or disable Cloudsql Memory utilization alert policy"

}

variable "enable_cloudsql_memory_90_alert" {
  type    = bool
  default = false
  description = "Enable or disable Cloudsql Memory utilization alert policy"
}

variable "enable_cloudsql_disk_80_alert" {
  type    = bool
  default = false
  description = "Enable or disable Cloudsql disk utilization alert policy"
}

variable "enable_cloudsql_disk_90_alert" {
  type    = bool
  default = false
  description = "Enable or disable Cloudsql disk utilization alert policy"
}

variable "enable_cloudsql_replication_lag_alert" {
  type    = bool
  default = false
  description = "Enable or disable Cloudsql replication_lag alert policy"
}

variable "enable_cloudsql_active_connections_alert" {
  type    = bool
  default = false
  description = "Enable or disable Cloudsql active-connections alert policy"
}

variable "iam_user" {
  type = string
  description = "IAM user to attach the custom role"
}

variable "create_custom_roles" {
  type    = bool
  default = true
  description = "Least-priviledge role"
}

variable "enable_viewer_role" {
  type    = bool
  default = true
  description = "Viewer role"
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
  type = string
  description = "Backend security policy or Edge securit policy"
}

variable "rule_priority" {
  type    = number
  default = 1000
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
  type = string
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

variable "region" {
  type = string
}

variable "function_name" {
  type        = string
  description = "Name of the Cloud Function used for automatic resource labeling"
}

variable "pubsub_topic_name" {
  type        = string
  description = "Name of the Pub/Sub topic used to receive resource change events"
}

variable "asset_feed_name" {
  type        = string
  description = "Name of the Cloud Asset Inventory feed used to monitor resource events"
}

variable "labels_to_apply" {
  type        = map(string)
  description = "Labels to attach automatically to newly created resources such as VMs, Cloud SQL instances, buckets, and Cloud Run services"
}