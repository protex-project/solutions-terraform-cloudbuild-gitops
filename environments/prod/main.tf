locals {
  env = "prod"
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

  if var.producer_name == "inita" {
    var.producer_pkey = "5KK65pGgYbUzdnWCUQ5FZ6QyhahF3ymtpf5zkv43h7HmLrAmdr5"
    var.producer_pub  = "EOS5zCg5bMvi4AWugeKmiQD5iQtjSrGKdSodTPXnQMYNdeDAm7w2N"
  }
  if var.producer_name == "initb" {
    var.producer_pkey = "5J48uZZVdmRxAn8sbosnwG293NnfJ3QG38jGLKJUzfpWajKdYWR"
    var.producer_pub  = "EOS6PNy7RbvX1Tj55N7GXFJbwGCmjuDVFDxC224g36MyWTDsUpzbz"
  }
  if var.producer_name == "initc" {
    var.producer_pkey = "5Khaw3mn1C7xkbRb33qdvADHNkYRaSWrC62tMjdYZGxWczsj6gZ"
    var.producer_pub  = "EOS7EXJSLeL3nSmweidjDG9tkeimmYQpt7MCjWiEfP6wDzWYJrSkH"
  }
  if var.producer_name == "initd" {
    var.producer_pkey = "5Jus9N9Skvc2GL6zaSrfdBHZZwUwiUJmWCpofPgMTwB2Px7ZAPD"
    var.producer_pub  = "EOS6W52PxQiFvWPt9DQnK5qdKXdWoJZNWbPdhXE9fBpqx554S2Zre"
  }

  metadata_startup_script = templatefile("./setup.sh", {producer_name = var.producer_name, producer_pkey = var.producer_pkey, producer_pub = var.producer_pub})
}

output "ip" {
  value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}

