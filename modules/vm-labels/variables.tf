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