provider "google" {
    project = "ankercloud-testing-account"
    region = "asia-south-1"  
}

resource "google_compute_subnetwork" "subnet_existing" {

  name          = var.subnet_name
  region        = var.region
  network       = var.network
  ip_cidr_range = var.ip_cidr_range

  dynamic "log_config" {

    for_each = var.enable_vpc_flow_logs ? [1] : []

    content {

      aggregation_interval = "INTERVAL_30_SEC"
      flow_sampling        = 0.5
      metadata             = "INCLUDE_ALL_METADATA"
    }
  }
}