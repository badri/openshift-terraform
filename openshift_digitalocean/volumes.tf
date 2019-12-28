// create the GlusterFS volumes associated with the nodes

resource "digitalocean_volume" "master_volume" {
  region = var.region
  name   = format("shapeblock-%s-master-glusterfs", var.domain)
  size   = var.volume_size
}

resource "digitalocean_volume" "node_volumes" {
  region = var.region
  name = format(
    "shapeblock-%s-%s%02d-glusterfs",
    var.domain,
    var.node_prefix,
    count.index + 1,
  )
  size  = var.node_volume_sizes[count.index]
  count = length(var.node_volume_sizes)
}
