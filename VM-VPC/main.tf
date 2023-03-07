provider "google" {
  project = "mi-dev-env"
  credentials = file("terraform.json")
  region  = "us-central1"
  zone    = "us-central1-a"
}
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}


