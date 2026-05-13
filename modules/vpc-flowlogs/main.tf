# locals {
#   network_pairs = [
#     for item in var.vpc_names : {
#       vpc    = split("/", item)[0]
#       subnet = split("/", item)[1]
#     }
#   ]
# }

# data "google_compute_subnetwork" "all" {
#   for_each = { for pair in local.network_pairs : pair.subnet => pair }
#   name     = each.value.subnet
#   region   = var.region
# }

# resource "google_compute_subnetwork" "network_logging" {
#   for_each = { for pair in local.network_pairs : pair.subnet => pair }
  
#   name    = each.value.subnet
#   region  = var.region
#   project = var.project_id
#   network = each.value.vpc # Now correctly identifies the parent VPC

#   log_config {
#     aggregation_interval = "INTERVAL_5_SEC"
#     flow_sampling        = 0.5
#     metadata             = "INCLUDE_ALL_METADATA"
#   }
# }

locals {
  parsed_vpc_list = compact(split(",", replace(var.vpc_names, " ", "")))
}

resource "null_resource" "enable_vpc_flow_logs" {
  for_each = (var.enable_vpc_flow_logs && var.enable_monitoring) ? toset(local.parsed_vpc_list) : []

  triggers = {
    subnets = join(",", local.parsed_vpc_list)
  }

  provisioner "local-exec" {
    command = <<EOT
      gcloud compute networks subnets update ${each.value} \
        --region=${var.region} \
        --project=${var.project_id} \
        --enable-flow-logs \
        --logging-aggregation-interval=interval-5-sec \
        --logging-flow-sampling=0.5 \
        --logging-metadata=include-all
    EOT
  }
}

resource "google_logging_project_bucket_config" "vpc_flow_log_bucket" {
  count          = var.enable_vpc_flow_logs ? 1 : 0
  project        = var.project_id
  location       = "global"
  bucket_id      = "${var.customer_name}-vpc-flow-logs"
  retention_days = var.environment == "Prod" ? 30 : 7
}