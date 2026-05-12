# 5xx Error Alert (Matches AWS alb_5xx logic)
resource "google_monitoring_alert_policy" "lb_5xx_alert" {
  for_each     = toset(var.lb_names)
  display_name = "LB 5xx Error Rate - ${each.value}"
  combiner     = "OR"

  conditions {
    display_name = "High 5xx Response Count"
    condition_threshold {
      # Filter for Load Balancer response codes
      filter = <<EOT
        metric.type="loadbalancing.googleapis.com/https/external/backend_request_count"
        AND resource.type="https_lb_rule"
        AND metric.label.response_code_class="500"
        AND resource.label.forwarding_rule_name="${each.value}"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = 10 # Alert if more than 10 errors occur
      duration        = "60s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }
  notification_channels = [var.notification_channel_id]
}

# 4xx Error Alert (Matches AWS high_4xx logic)
resource "google_monitoring_alert_policy" "lb_4xx_alert" {
  for_each     = toset(var.lb_names)
  display_name = "LB 4xx Error Rate - ${each.value}"
  combiner     = "OR"

  conditions {
    display_name = "High 4xx Response Count"
    condition_threshold {
      filter = <<EOT
        metric.type="loadbalancing.googleapis.com/https/external/backend_request_count"
        AND resource.type="https_lb_rule"
        AND metric.label.response_code_class="400"
        AND resource.label.forwarding_rule_name="${each.value}"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = 50 # Alert if more than 50 errors occur
      duration        = "60s"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }
  notification_channels = [var.notification_channel_id]
}