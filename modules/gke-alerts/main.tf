# modules/gke-alerts/main.tf

resource "google_monitoring_alert_policy" "gke_node_cpu_80" {

  count = var.enable_gke_node_cpu_80_alert ? 1 : 0

  display_name = "GKE Node CPU Utilization > 80%"

  combiner = "OR"

  conditions {

    display_name = "GKE Node CPU > 80%"

    condition_threshold {

      filter = "metric.type=\"kubernetes.io/node/cpu/allocatable_utilization\" AND resource.type=\"k8s_node\""

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



resource "google_monitoring_alert_policy" "gke_node_memory_80" {

  count = var.enable_gke_node_memory_80_alert ? 1 : 0

  display_name = "GKE Node Memory Utilization > 80%"

  combiner = "OR"

  conditions {

    display_name = "GKE Node Memory > 80%"

    condition_threshold {

      filter = "metric.type=\"kubernetes.io/node/memory/allocatable_utilization\" AND resource.type=\"k8s_node\""

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



resource "google_monitoring_alert_policy" "gke_node_disk_80" {

  count = var.enable_gke_node_disk_80_alert ? 1 : 0

  display_name = "GKE Node Disk Utilization > 80%"

  combiner = "OR"

  conditions {

    display_name = "GKE Node Disk > 80%"

    condition_threshold {

      filter = "metric.type=\"kubernetes.io/node/ephemeral_storage/used_bytes\" AND resource.type=\"k8s_node\""

      comparison      = "COMPARISON_GT"
      threshold_value = 80
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "gke_crashloopbackoff" {

  count = var.enable_gke_crashloopbackoff_alert ? 1 : 0

  display_name = "GKE CrashLoopBackOff Pods"

  combiner = "OR"

  conditions {

    display_name = "CrashLoopBackOff Pods"

    condition_threshold {

      filter = "metric.type=\"kubernetes.io/container/restart_count\" AND resource.type=\"k8s_container\""

      comparison      = "COMPARISON_GT"
      threshold_value = 5
      duration        = "300s"

      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "gke_pending_pods" {

  count = var.enable_gke_pending_pods_alert ? 1 : 0

  display_name = "GKE Pending Pods"

  combiner = "OR"

  conditions {

    display_name = "Pending Pods"

    condition_threshold {

      filter = "metric.type=\"kubernetes.io/pod/status/unschedulable\" AND resource.type=\"k8s_pod\""

      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "gke_cluster_cpu_memory_saturation" {

  count = var.enable_gke_cluster_cpu_memory_saturation_alert ? 1 : 0

  display_name = "GKE Cluster CPU/Memory Saturation"

  combiner = "OR"

  conditions {

    display_name = "Cluster CPU Saturation"

    condition_threshold {

      filter = "metric.type=\"kubernetes.io/node/cpu/allocatable_utilization\" AND resource.type=\"k8s_node\""

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



resource "google_monitoring_alert_policy" "gke_backup_failure" {

  count = var.enable_gke_backup_failure_alert ? 1 : 0

  display_name = "GKE Backup Failure Alert"

  combiner = "OR"

  conditions {

    display_name = "Backup Failure"

    condition_threshold {

      filter = "resource.type=\"gkebackup.googleapis.com/Backup\""

      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_COUNT"
      }
    }
  }

  notification_channels = [var.notification_channel_id]
}