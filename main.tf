provider "google" {
  project = "ankercloud-testing-account"
  region  = "asia-south1"
  zone    = "asia-south1-a"
}

resource "google_compute_instance" "test" {
  name         = "test-gaia"
  machine_type = "e2-micro"
  zone         = "asia-south1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # gives public IP
    }
  }

  tags = ["http-server"]
}