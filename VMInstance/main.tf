# This is the provider used to spin up the gcloud instance
provider "google" {
 
  project = "mi-dev-env"
  credentials = file("terraform.json")
  region  = "us-east1"
  
}

resource "google_compute_instance" "vm-instance" {
  name         = "test"
  machine_type = "f1-micro"
  zone         = "us-east1-b"


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


