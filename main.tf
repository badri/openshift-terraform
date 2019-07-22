module "openshift_digitalocean" {
  source            = "./openshift_digitalocean"
  key_name          = "${var.key_name}"
  public_key        = "${var.public_key}"
  region            = "${var.region}"
  master_size       = "${var.master_size}"
  node_sizes        = "${var.node_sizes}"
  node_regions      = "${var.node_regions}"
  domain            = "${var.domain}"
}
