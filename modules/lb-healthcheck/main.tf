resource "google_compute_health_check" "hc" {

  name    = var.health_check_name
  project = var.project_id

  timeout_sec        = 5
  check_interval_sec = 10

  http_health_check {
    port         = var.port
    request_path = var.request_path
  }
}

resource "google_compute_backend_service" "backend" {

  name                  = var.backend_service_name
  project               = var.project_id

  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL"

  health_checks = [
    google_compute_health_check.hc.id
  ]
}