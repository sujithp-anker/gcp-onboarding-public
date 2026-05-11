variable "display_name" {
  type        = string
  description = "Display name for alerts"
  default = ""
}

variable "email_address" {
  type        = string
  description = "Email for alerts"
  default = ""
}

variable "days_in_cycle" {
   type        = number
   description = "Snapshot frequency"
 }

 variable "start_time" {
   type        = string 
   description = "Snapshot start time (hour)"
 }

 variable "retention_days" {
   type        = number
   description = "Retention period"
 }

 variable "enable_vm_cpu_80_alert" {
  type    = bool
  default = false
}

variable "enable_vm_cpu_90_alert" {
  type    = bool
  default = false
}

variable "enable_vm_memory_80_alert" {
  type    = bool
  default = false
}

variable "enable_vm_memory_90_alert" {
  type    = bool
  default = false
}

variable "enable_vm_disk_80_alert" {
  type    = bool
  default = false
}

variable "enable_vm_disk_90_alert" {
  type    = bool
 default = false
}

variable "enable_cloudsql_cpu_80_alert" {
  type    = bool
  default = false
}

variable "enable_cloudsql_cpu_90_alert" {
  type    = bool
  default = false
}

variable "enable_cloudsql_memory_80_alert" {
  type    = bool
  default = false
}

variable "enable_cloudsql_memory_90_alert" {
  type    = bool
  default = false
}

variable "enable_cloudsql_disk_80_alert" {
  type    = bool
  default = false
}

variable "enable_cloudsql_disk_90_alert" {
  type    = bool
  default = false
}

variable "enable_cloudsql_replication_lag_alert" {
  type    = bool
  default = false
}

variable "enable_cloudsql_active_connections_alert" {
  type    = bool
  default = false
}

variable "project_id" {
  type = string
}

variable "iam_user" {
  type = string
}

variable "create_custom_roles" {
  type    = bool
  default = true
}

variable "enable_viewer_role" {
  type    = bool
  default = true
}

variable "health_check_name" {
  type = string
}

variable "check_interval_sec" {
  type = number
}

variable "port" {
  type = number
}

variable "request_path" {
  type = string
}

variable "timeout_sec" {
  type = number
}

variable "healthy_threshold" {
  type = number
}

variable "unhealthy_threshold" {
  type = number
}

variable "security_policy_name" {
  type = string
}

variable "rule_priority" {
  type    = number
  default = 1000
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
  default = "allow"
}

# root/variables.tf

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

#variable "enable_budget_alert" {
#  type    = bool
# default = false
#}

#variable "billing_account_id" {
#  type = string
#}

#variable "budget_name" {
#  type = string
#}

#variable "project_number" {
#  type = string
#}

#variable "budget_amount" {
#  type = number
#}

variable "region" {
  type = string
}

variable "project_id" {
  type = string
}

variable "function_name" {
  type = string
}

variable "pubsub_topic_name" {
  type = string
}

variable "asset_feed_name" {
  type = string
}

variable "labels_to_apply" {
  type = map(string)
}
