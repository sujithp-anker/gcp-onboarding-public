resource "google_compute_security_policy" "cloud_armor_policy" {

  name    = var.security_policy_name
  project = var.project_id

  type = "CLOUD_ARMOR"

  rule {

    priority = var.rule_priority

    action = var.rule_action

    match {

      expr {
        expression = var.expression
      }
    }
  }

  rule {

    priority = 2147483647

    action = var.default_rule_action

    match {

      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = ["*"]
      }
    }
  }
}