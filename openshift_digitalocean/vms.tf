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

resource "digitalocean_droplet" "infra" {
  image              = var.image
  name               = format("infra.%s.shapeblock.cloud", var.domain)
  region             = var.region
  size               = var.infra_size
  ssh_keys           = [digitalocean_ssh_key.keypair.id]
  count              = 1
  volume_ids         = [digitalocean_volume.infra_volume.id]
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
  tags       = [digitalocean_tag.cluster.name]
  private_networking = true
}
