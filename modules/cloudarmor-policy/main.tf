resource "google_compute_security_policy" "cloud_armor_policy" {

  name        = var.security_policy_name
  description = var.description

  project = var.project_id

  type = "CLOUD_ARMOR"

  rule {

    priority = 2147483647

    action = var.default_rule_action

    match {

      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = ["*"]
      }
    }

    description = "Default rule"
  }
}