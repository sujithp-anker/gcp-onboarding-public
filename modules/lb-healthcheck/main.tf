resource "google_compute_health_check" "hc" {

  name    = var.health_check_name
  project = var.project_id

  check_interval_sec  = var.check_interval_sec
  timeout_sec         = var.timeout_sec

  healthy_threshold   = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold

  http_health_check {
    port         = var.port
    request_path = var.request_path
  }
}