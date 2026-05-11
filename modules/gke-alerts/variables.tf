# modules/gke-alerts/variables.tf

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

variable "notification_channel_id" {
  type = string
}