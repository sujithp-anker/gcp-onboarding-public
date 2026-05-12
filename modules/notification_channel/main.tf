provider "google" {
    project = "ankercloud-testing-account"
    region = "asia-south-1"  
}

resource "google_monitoring_notification_channel" "email" {
  for_each     = toset(split(",", var.email_address))
  
  display_name = "${var.display_name} - ${each.value}"
  type         = "email"
  labels = {
    email_address = trimspace(each.value)
  }
}
