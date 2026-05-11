resource "google_monitoring_alert_policy" "iam_policy_change" {

  count = var.enable_iam_policy_change_alert ? 1 : 0

  display_name = "IAM Policy Change"

  combiner = "OR"

  conditions {

    display_name = "IAM Policy Change Detected"

    condition_matched_log {

      filter = <<EOT
protoPayload.methodName="SetIamPolicy"
EOT
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "firewall_events" {

  count = var.enable_firewall_events_alert ? 1 : 0

  display_name = "Firewall Events"

  combiner = "OR"

  conditions {

    display_name = "Firewall Event Detected"

    condition_matched_log {

      filter = <<EOT
resource.type="gce_firewall_rule"
EOT
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "instance_delete" {

  count = var.enable_instance_delete_alert ? 1 : 0

  display_name = "Instance Delete"

  combiner = "OR"

  conditions {

    display_name = "VM Instance Deleted"

    condition_matched_log {

      filter = <<EOT
protoPayload.methodName="v1.compute.instances.delete"
EOT
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "instance_insert" {

  count = var.enable_instance_insert_alert ? 1 : 0

  display_name = "Instance Insert"

  combiner = "OR"

  conditions {

    display_name = "VM Instance Created"

    condition_matched_log {

      filter = <<EOT
protoPayload.methodName="v1.compute.instances.insert"
EOT
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "label_modification" {

  count = var.enable_label_modification_alert ? 1 : 0

  display_name = "Label Modification"

  combiner = "OR"

  conditions {

    display_name = "Resource Label Modified"

    condition_matched_log {

      filter = <<EOT
protoPayload.methodName:"setLabels"
EOT
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "service_account_creation" {

  count = var.enable_service_account_creation_alert ? 1 : 0

  display_name = "Service Account Creation"

  combiner = "OR"

  conditions {

    display_name = "Service Account Created"

    condition_matched_log {

      filter = <<EOT
protoPayload.methodName="google.iam.admin.v1.CreateServiceAccount"
EOT
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "disk_deletion" {

  count = var.enable_disk_deletion_alert ? 1 : 0

  display_name = "Disk Deletion"

  combiner = "OR"

  conditions {

    display_name = "Disk Deleted"

    condition_matched_log {

      filter = <<EOT
protoPayload.methodName="v1.compute.disks.delete"
EOT
    }
  }

  notification_channels = [var.notification_channel_id]
}



resource "google_monitoring_alert_policy" "service_account_key_deletion" {

  count = var.enable_service_account_key_deletion_alert ? 1 : 0

  display_name = "Service Account Key Deletion"

  combiner = "OR"

  conditions {

    display_name = "Service Account Key Deleted"

    condition_matched_log {

      filter = <<EOT
protoPayload.methodName="google.iam.admin.v1.DeleteServiceAccountKey"
EOT
    }
  }

  notification_channels = [var.notification_channel_id]
}