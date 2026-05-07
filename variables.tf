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

 variable "enable_cpu_80_alert" {
  type    = bool
  default = false
  description = "CPU exceeds 80%"
}

variable "enable_cpu_90_alert" {
  type    = bool
  default = false
  description = "CPU exceeds 90%"
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