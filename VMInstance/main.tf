# This is the provider used to spin up the VM instance
provider "google" {
 
  project = "mi-cloud-dev"
  region  = "us-central1"
  
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
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}



