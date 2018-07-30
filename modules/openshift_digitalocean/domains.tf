// master domain

resource "digitalocean_domain" "openshift_base" {
  name       = "${var.domain}"
  ip_address = "${digitalocean_droplet.master.ipv4_address}"
}

// console url
resource "digitalocean_record" "openshift_web_console" {
  domain = "${var.domain}"
  type   = "A"
  name   = "console"
  value  = "${digitalocean_droplet.master.ipv4_address}"
}

// apps subdomains
resource "digitalocean_record" "openshift_apps" {
  domain = "${var.domain}"
  type   = "CNAME"
  name   = "*.apps"
  value  = "@"
}

// node urls
resource "digitalocean_record" "openshift_nodes" {
  count  = "${var.nodes_count}"
  domain = "${var.domain}"
  type   = "A"
  name   = "${format("%s%02d", var.node_prefix, count.index + 1)}"
  value  = "${element(digitalocean_droplet.nodes.*.ipv4_address, count.index)}"
}
