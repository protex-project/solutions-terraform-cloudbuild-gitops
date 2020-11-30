locals {
  env = "node"
  producer_pkey = "${lookup(var.pkeys, var.producer_name)}"
  producer_pub  = "${lookup(var.pubs, var.producer_name)}"
}

terraform {
  experiments = [variable_validation]
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "default" {
  name         = var.node_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      type  = "pd-ssd"
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size  = "100"
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
	# nat_ip = google_compute_address.static.address
    }
  }

  metadata_startup_script = templatefile("./setup.sh", {producer_name = var.producer_name, producer_pkey = local.producer_pkey, producer_pub = local.producer_pub})
}

output "ip" {
  value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}

