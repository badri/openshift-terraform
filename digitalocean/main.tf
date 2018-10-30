//  Create the infra needed for OpenShift cluster in DO.

module "openshift_digitalocean" {
  source               = "../modules/openshift_digitalocean"

  key_name             = "openshift"
  public_key_path      = "${var.public_key_path}"
  region               = "${var.region}"
  master_size          = "${var.master_size}"
  node_size            = "${var.node_size}"
  nodes_count          = "${var.nodes_count}"
  volume_size          = "${var.volume_size}"
  domain               = "${var.domain}"
}


module "inventory_generation" {
  source = "../modules/inventory_generation"

  master_domain = "${module.openshift_digitalocean.master_domain}",
  node_domains = "${module.openshift_digitalocean.node_domains}",
  apps_subdomain = "${module.openshift_digitalocean.apps_subdomain}",
  master_ip_address = "${module.openshift_digitalocean.master_ip_address}",
  node_ip_address = "${module.openshift_digitalocean.node_ip_address}",
  private_key_path = "${var.private_key_path}"
}
