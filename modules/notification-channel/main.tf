provider "google" {
    project = "ankercloud-testing-account"
    region = "asia-south-1"  
}

resource "google_monitoring_notification_channel" "email-1" {
    display_name = var.display-name 
    labels = var.email-address
}

