data "google_project" "project" {
  project_id = var.project_id
}

locals {
  threshold_list = split(",", var.thresholds)
}

resource "google_billing_budget" "budget" {
  count           = var.enable_budget_alert ? 1 : 0
  billing_account = var.billing_account_id
  display_name    = "Project-Budget-Alert"

  budget_filter {
    projects = ["projects/${data.google_project.project.number}"]
  }

  amount {
    specified_amount {
      currency_code = "USD"
      units         = var.budget_limit
    }
  }

  dynamic "threshold_rules" {
    for_each = local.threshold_list
    content {
      threshold_percent = tonumber(trimspace(threshold_rules.value)) / 100
      spend_basis       = "FORECASTED_SPEND"
    }
  }

  all_updates_rule {
    monitoring_notification_channels = [var.notification_channel_id]
  }
}