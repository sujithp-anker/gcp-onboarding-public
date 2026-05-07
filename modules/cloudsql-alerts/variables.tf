variable "notification_channel_id" {
  type = string
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
  description = "Default=100"
}