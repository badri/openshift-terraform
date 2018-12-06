output "master_domain" {
  value = "${var.console_subdomain}.${var.domain}"
}

output "node_domains" {
  value = "${formatlist("%s.%s", digitalocean_droplet.nodes.*.name, var.domain)}"
}

output "master_ip_address" {
  value = "${digitalocean_droplet.master.ipv4_address}"
}

output "node_ip_address" {
  value = "${digitalocean_droplet.nodes.*.ipv4_address}"
}

output "apps_subdomain" {
  value = "${var.apps_subdomain}.${var.domain}"
}
