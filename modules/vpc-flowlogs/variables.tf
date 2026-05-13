variable "project_id" { type = string }
variable "customer_name" { type = string }
variable "region" { type = string }
variable "environment" { type = string }
variable "vpc_names" { type = string }
variable "enable_vpc_flow_logs" { type = bool }
variable "enable_monitoring" {
  type = bool                           
}