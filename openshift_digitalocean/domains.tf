// console url
resource "dnsimple_record" "openshift_web_console" {
  domain =  "shapeblock.cloud"
  type   = "A"
  name   = format("console.%s", var.domain)
  value  = digitalocean_droplet.master[0].ipv4_address
}

// infra url
resource "dnsimple_record" "openshift_infra_node" {
  domain =  "shapeblock.cloud"
  type   = "A"
  name   = format("infra.%s", var.domain)
  value  = digitalocean_droplet.infra[0].ipv4_address
}


// apps subdomains
resource "dnsimple_record" "openshift_apps" {
  domain =  "shapeblock.cloud"
  type   = "CNAME"
  name   = format("*.apps.%s", var.domain)
  value  = format("%s.shapeblock.cloud", var.domain)
}

// router URL
resource "dnsimple_record" "openshift_router" {
  domain =  "shapeblock.cloud"
  type   = "A"
  name   = var.domain
  value  = digitalocean_droplet.infra[0].ipv4_address
}

// node urls
resource "dnsimple_record" "openshift_nodes" {
  count  = length(var.node_sizes)
  domain =  "shapeblock.cloud"
  type   = "A"
  name   = element(digitalocean_droplet.nodes.*.name, count.index)
  value  = element(digitalocean_droplet.nodes.*.ipv4_address, count.index)
}
