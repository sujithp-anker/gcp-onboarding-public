resource "google_compute_health_check" "hc" {

  name = var.health_check_name

  http_health_check {
    port         = var.port
    request_path = var.request_path
  }
}

resource "null_resource" "attach_health_check_global" {

  count = var.is_global ? 1 : 0

  provisioner "local-exec" {

    command = <<EOT
gcloud compute backend-services update ${var.backend_service_name} \
  --global \
  --health-checks=${google_compute_health_check.hc.self_link} \
  --project=${var.project_id}
EOT

  }

  depends_on = [
    google_compute_health_check.hc
  ]
}

resource "null_resource" "attach_health_check_regional" {

  count = var.is_global ? 0 : 1

  provisioner "local-exec" {

    command = <<EOT
gcloud compute backend-services update ${var.backend_service_name} \
  --region=${var.region} \
  --health-checks=${google_compute_health_check.hc.self_link} \
  --project=${var.project_id}
EOT

  }

  depends_on = [
    google_compute_health_check.hc
  ]
}