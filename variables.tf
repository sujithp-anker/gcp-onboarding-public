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
variable "enable_ops_agent" {
  type        = bool
  description = "Enable Ops Agent"
  default     = false
}

variable "subnet_name" {
  type = string
}

variable "region" {
  type = string
}

variable "network" {
  type = string
}

variable "ip_cidr_range" {
  type = string
}

variable "enable_vpc_flow_logs" {
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

variable "backend_service_name" {
  type = string
}

variable "region" {
  type = string
}

variable "health_check_name" {
  type = string
}

variable "port" {
  type = number
}

variable "request_path" {
  type = string
}

variable "is_global" {
  type = bool
}

variable "bucket_names" {
  type = list(string)
}

variable "lifecycle_age_days" {
  type = number
}

variable "zone" {
  type = string
}

variable "instance_names" {
  type = string
}

variable "enable_deletion_protection" {
  type    = bool
  default = true
}