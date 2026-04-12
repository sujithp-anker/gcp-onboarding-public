variable "display_name" {
  type        = string
  description = "Display name for alerts"
}

variable "email_address" {
  type        = string
  description = "Email for alerts"
}

variable "days_in_cycle" {
  type        = number
  description = "Snapshot frequency"
}

variable "start_time" {
  type        = number
  description = "Snapshot start time (hour)"
}

variable "retention_days" {
  type        = number
  description = "Retention period"
}