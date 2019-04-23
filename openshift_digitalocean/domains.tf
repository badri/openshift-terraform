// master domain

resource "dnsimple_record" "openshift_base" {
  domain = "shapeblock.cloud"
  value  = "${digitalocean_droplet.master.ipv4_address}"
  type   = "A"
  name   = "${var.domain}"
}

// console url
resource "dnsimple_record" "openshift_web_console" {
  domain = "${dnsimple_record.openshift_base.domain}"
  type   = "A"
  name   = "${format("console.%s", var.domain)}"
  value  = "${digitalocean_droplet.master.ipv4_address}"
}

// apps subdomains
resource "dnsimple_record" "openshift_apps" {
  domain = "${dnsimple_record.openshift_base.domain}"
  type   = "CNAME"
  name   = "${format("*.apps.%s", var.domain)}"
  value  = "${format("%s.shapeblock.cloud", var.domain)}"
}

// node urls
resource "dnsimple_record" "openshift_nodes" {
  count  = "${length(var.node_sizes)}"
  domain = "${dnsimple_record.openshift_base.domain}"
  type   = "A"
  name   = "${format("%s%02d.%s", var.node_prefix, count.index + 1, var.domain)}"
  value  = "${element(digitalocean_droplet.nodes.*.ipv4_address, count.index)}"
}
