variable "project_id" {
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

variable "check_interval_sec" {
  type = number
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