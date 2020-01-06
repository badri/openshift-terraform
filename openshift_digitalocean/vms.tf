//  Create an SSH keypair
resource "digitalocean_ssh_key" "keypair" {
  name       = var.key_name
  public_key = var.public_key
}

resource "digitalocean_tag" "cluster" {
  name = var.domain
}

resource "digitalocean_droplet" "master" {
  image              = var.image
  name               = format("%s.%s.shapeblock.cloud", var.console_subdomain, var.domain)
  region             = var.region
  size               = var.master_size
  ssh_keys           = [digitalocean_ssh_key.keypair.id]
  count              = 1
  volume_ids         = [digitalocean_volume.master_volume.id]
  private_networking = true
  tags               = [digitalocean_tag.cluster.name]
}

resource "digitalocean_droplet" "nodes" {
  image = var.image
  name = format(
    "%s%02d.%s.shapeblock.cloud",
    var.node_prefix,
    count.index + 1,
    var.domain,
  )
  region     = var.region
  size       = var.node_sizes[count.index]
  ssh_keys   = [digitalocean_ssh_key.keypair.id]
  count      = length(var.node_sizes)
  volume_ids = [element(digitalocean_volume.node_volumes.*.id, count.index)]
  // TODO: add a tag for infra
  tags       = [digitalocean_tag.cluster.name]
  private_networking = true
}
// we don't need the bastion setup at all in DO.

/*
resource "digitalocean_droplet" "bastion" {
  image              = "docker-18-04"
  name               = format("bastion.%s.shapeblock.cloud", var.domain)
  region             = var.region
  size               = "s-1vcpu-1gb"
  ssh_keys           = [digitalocean_ssh_key.keypair.id]
  tags               = [digitalocean_tag.cluster.name]
  private_networking = true
}
*/

// TODO: firewall 1 - only for OKD masters and nodes
// TODO: firewall 2 - for bastion only
