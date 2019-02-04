//  Create an SSH keypair
resource "digitalocean_ssh_key" "keypair" {
  name       = "${var.key_name}"
  public_key = "${var.public_key}"
}

resource "digitalocean_droplet" "master" {
  image      = "${var.image}"
  name       = "${var.master_hostname}"
  region     = "${var.region}"
  size       = "${var.master_size}"
  ssh_keys   = ["${digitalocean_ssh_key.keypair.id}"]
  count      = 1
  volume_ids = ["${digitalocean_volume.master_volume.id}"]
  private_networking = true
}

resource "digitalocean_droplet" "nodes" {
  image      = "${var.image}"
  name       = "${format("%s%02d", var.node_prefix, count.index + 1)}"
  region     = "${var.region}"
  size       = "${var.node_size}"
  ssh_keys   = ["${digitalocean_ssh_key.keypair.id}"]
  count      = "${var.nodes_count}"
  volume_ids = ["${element(digitalocean_volume.node_volumes.*.id, count.index)}"]
}
