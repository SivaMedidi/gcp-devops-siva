provider "google" {
  project = "mi-dev-env"
  credentials = file("terraform.json")
  region  = "us-central1"
  zone    = "us-central1-a"
}
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name = "test-vm-${count.index}"
  count        = 2
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-10-buster-v20221102"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      // Ephemeral IP
    }
  }
}

