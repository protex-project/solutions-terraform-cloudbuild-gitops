locals {
  env = "prod"
}

provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
  zone    = "${var.zone}"
}

resource "google_compute_instance" "default" {
  name         = "${var.node_name}"
  machine_type = "${machine_type}"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      type  = "pd-ssd"
      image = "ubuntu-cloud/ubuntu-18.04"
      size  = "100"
    }
  }

  network_interface {
    network = "default"
  }

  metadata_startup_script = "${file("./start.sh")}"
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}

