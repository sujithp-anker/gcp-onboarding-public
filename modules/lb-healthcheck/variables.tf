variable "project_id" {
  type = string
}

variable "health_check_name" {
  type = string
}

variable "backend_service_name" {
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