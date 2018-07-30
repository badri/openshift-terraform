//  Create the infra needed for OpenShift cluster in DO.
module "openshift_digitalocean" {
  source               = "./modules/openshift_digitalocean"
  key_name             = "openshift"
  public_key_path      = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  region               = "${var.region}"
  master_size          = "${var.master_size}"
  node_size            = "${var.node_size}"
  nodes_count          = "${var.nodes_count}"
  volume_size          = "${var.volume_size}"
  domain               = "${var.domain}"
}
