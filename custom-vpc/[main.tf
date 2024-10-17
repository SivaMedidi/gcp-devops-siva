provider "google" {
  project = "mi-cloud-dev"
  region  = "us-central1"
}

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "custom_subnet" {
  name          = "custom-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.name
}

resource "google_compute_instance" "vm-instance1" {
  name         = "myfirstvm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  tags = ["web-app"]


  boot_disk {
    initialize_params {
      image = "debian-10-buster-v20221102"
    }
  }
    
  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.custom_subnet.name

    access_config {
      // Ephemeral IP
    }
  }
}
