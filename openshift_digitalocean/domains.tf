// master domain

resource "dnsimple_record" "openshift_base" {
  domain = "shapeblock.cloud"
  value  = digitalocean_droplet.master[0].ipv4_address
  type   = "A"
  name   = var.domain
}

// console url
resource "dnsimple_record" "openshift_web_console" {
  domain = dnsimple_record.openshift_base.domain
  type   = "A"
  name   = format("console.%s", var.domain)
  value  = digitalocean_droplet.master[0].ipv4_address
}

// apps subdomains
resource "dnsimple_record" "openshift_apps" {
  domain = dnsimple_record.openshift_base.domain
  type   = "CNAME"
  name   = format("*.apps.%s", var.domain)
  value  = format("%s.shapeblock.cloud", var.domain)
}

// router URL
resource "dnsimple_record" "openshift_nodes" {
  domain = dnsimple_record.openshift_base.domain
  type   = "A"
  name   = var.domain
  value  = digitalocean_droplet.infra[0].ipv4_address
}
