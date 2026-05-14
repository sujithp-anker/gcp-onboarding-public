locals {
  network_pairs = {
    for item in compact(split(",", replace(var.vpc_names, " ", ""))) :
    split("/", item)[1] => split("/", item)[0]
  }
}

import {
  for_each = local.network_pairs
  id = "projects/${var.project_id}/regions/${var.region}/subnetworks/${each.key}"  
  to = google_compute_subnetwork.network_logging[each.key]
}

resource "google_compute_subnetwork" "network_logging" {
  for_each = local.network_pairs
  
  name    = each.key
  region  = var.region
  project = var.project_id
  
  network = each.value 

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

  lifecycle {
    ignore_changes = [
      ip_cidr_range,
      network,
      secondary_ip_range,
      private_ip_google_access,
      stack_type,
      ipv6_access_type
    ]
    prevent_destroy = true 
  }
}

resource "google_logging_project_bucket_config" "vpc_flow_log_bucket" {
  count          = var.enable_vpc_flow_logs ? 1 : 0
  project        = var.project_id
  location       = "global"
  bucket_id      = "${var.customer_name}-vpc-flow-logs"
  retention_days = var.environment == "Prod" ? 30 : 7
}