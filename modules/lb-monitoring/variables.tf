variable "lb_names" {
  type        = list(string)
  description = "List of existing Global HTTP(S) Load Balancer (Forwarding Rule) names to monitor for 4xx/5xx errors."
}

variable "notification_channel_id" {
  type        = string
  description = "The ID of the notification channel where Load Balancer error alerts will be sent."
}