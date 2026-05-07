resource "google_monitoring_alert_policy" "alert_policy_cpu" {

  count = var.enable_cpu_80_alert ? 1 : 0

  display_name = "CPU Utilization > 80%"

  combiner = "OR"

  conditions {
    display_name = "CPU > 80%"

    condition_threshold {

      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""

      comparison      = "COMPARISON_GT"
      threshold_value = 0.8
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}

resource "google_monitoring_alert_policy" "alert_policy_cpu_90" {

  count = var.enable_cpu_90_alert ? 1 : 0

  display_name = "CPU Utilization > 90%"

  combiner = "OR"

  conditions {
    display_name = "CPU > 90%"

    condition_threshold {

      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""

      comparison      = "COMPARISON_GT"
      threshold_value = 0.9
      duration        = "600s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}