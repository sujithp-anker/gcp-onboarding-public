variable "enable_iam_policy_change_alert" {
  type    = bool
  default = false
}

variable "enable_firewall_events_alert" {
  type    = bool
  default = false
}

variable "enable_instance_delete_alert" {
  type    = bool
  default = false
}

variable "enable_instance_insert_alert" {
  type    = bool
  default = false
}

variable "enable_label_modification_alert" {
  type    = bool
  default = false
}

variable "enable_service_account_creation_alert" {
  type    = bool
  default = false
}

variable "enable_disk_deletion_alert" {
  type    = bool
  default = false
}

variable "enable_service_account_key_deletion_alert" {
  type    = bool
  default = false
}

variable "notification_channel_id" {
  type = string
}