provider "google" {
  region = "asia-south-1"
}

module "notification-channel" {
  source = "./modules/notification-channel"
  display-name = "MS-Alerts"
  email-address = "ms.alerts@ankercloud.com"
}