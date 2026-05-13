locals {
  network_pairs = [
    for item in var.vpc_names : {
      vpc    = split("/", item)[0]
      subnet = split("/", item)[1]
    }
  ]
}

data "google_compute_subnetwork" "all" {
  for_each = { for pair in local.network_pairs : pair.subnet => pair }
  name     = each.value.subnet
  region   = var.region
}

resource "google_compute_subnetwork" "network_logging" {
  for_each = { for pair in local.network_pairs : pair.subnet => pair }
  
  name    = each.value.subnet
  region  = var.region
  project = var.project_id
  network = each.value.vpc # Now correctly identifies the parent VPC

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}