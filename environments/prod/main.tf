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
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      type  = "pd-ssd"
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size  = "100"
    }
  }

  network_interface {
    network = "${var.network}"
    access_config {
	# nat_ip = "${google_compute_address.static.address}"
    }
  }

  metadata_startup_script = "${file("./setup.sh")}"
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}

