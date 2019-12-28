output "master_domain" {
  value = format("%s.%s.shapeblock.cloud", var.console_subdomain, var.domain)
}

output "master_id" {
  value = digitalocean_droplet.master[0].id
}

output "master_ip_address" {
  value = digitalocean_droplet.master[0].ipv4_address
}

output "node_ip_address" {
  value = digitalocean_droplet.nodes.*.ipv4_address
}

output "node_ids" {
  value = digitalocean_droplet.nodes.*.id
}

output "apps_subdomain" {
  value = format("%s.%s.shapeblock.cloud", var.apps_subdomain, var.domain)
}
