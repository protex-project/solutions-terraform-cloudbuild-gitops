output "ips" {
  value = "${zipmap(google_compute_instance.node[*].name, google_compute_instance.node[*].network_interface.0.access_config.0.nat_ip)}"
}
