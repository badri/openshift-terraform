// create the GlusterFS volumes associated with the nodes

resource "digitalocean_volume" "master_volume" {
  region = var.region
  name   = format("shapeblock-%s-master-glusterfs", var.domain)
  size   = var.volume_size
  tags   = [digitalocean_tag.cluster.name]
}

resource "digitalocean_volume" "infra_volume" {
  region = var.region
  name   = format("shapeblock-%s-infra-glusterfs", var.domain)
  size   = var.volume_size
  count  = var.infra_size != null ? 1 : 0
  tags   = [digitalocean_tag.cluster.name]
}

resource "digitalocean_volume" "node_volumes" {
  region = var.region
  name = format(
    "shapeblock-%s-%s%02d-disk",
    var.domain,
    var.node_prefix,
    count.index + 1,
  )
  size  = var.volume_size
  count = length(var.node_sizes)
  tags  = [digitalocean_tag.cluster.name]
}
