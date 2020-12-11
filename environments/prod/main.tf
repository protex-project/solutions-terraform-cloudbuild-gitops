terraform {
  experiments = [variable_validation]
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "node" {
  count	       = length(var.nodes)
  name         = var.nodes[count.index].name
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

  metadata_startup_script = templatefile("./setup.sh", {producer_name = var.nodes[count.index].name, producer_account = var.nodes[count.index].account, producer_pkey = lookup(var.pkeys, var.nodes[count.index].account), producer_pub = lookup(var.pubs, var.nodes[count.index].account), producer_peers = lookup(var.shardes, var.nodes[count.index].shard)})
}

