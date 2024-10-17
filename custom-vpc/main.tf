provider "google" {
  project = "mi-cloud-dev"
  region  = "us-central1"
}

#This block will create a custom network
resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = false
}

#This block will create a custom subnet
resource "google_compute_subnetwork" "custom_subnet" {
  name          = "custom-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.name
}

#This block will create a VM Instance
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
