// create the GlusterFS volumes associated with the nodes

resource "digitalocean_volume" "master_volume" {
  region = "${var.region}"
  name   = "${format("shapeblock-%s-master-glusterfs", var.domain)}"
  size   = "${var.volume_size}"
}

resource "digitalocean_volume" "node_volumes" {
  region = "${var.region}"
  name   = "${format("shapeblock-%s-%s%02d-glusterfs", var.domain, var.node_prefix, count.index + 1)}"
  size   = "${var.volume_size}"
  count  = "${var.nodes_count}"
}
