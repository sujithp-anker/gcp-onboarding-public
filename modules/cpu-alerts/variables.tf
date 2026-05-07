variable "notification_channel_id" {
  type        = string
  description = "Notification channel ID from the channel module"
}

variable "enable_cpu_80_alert" {
  type        = bool
  description = "Enable CPU 80 percent alert"
  default     = false
}

variable "enable_cpu_90_alert" {
  type        = bool
  description = "Enable CPU 90 percent alert"
  default     = false
}