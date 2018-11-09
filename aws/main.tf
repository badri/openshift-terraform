//  Create the infra needed for OpenShift cluster in AWS.
module "openshift_aws" {
  source               = "../modules/openshift_aws"

  key_name             = "openshift"
  public_key_path      = "${var.public_key_path}"
  region               = "${var.region}"
  master_size          = "${var.master_size}"
  node_size            = "${var.node_size}"
  nodes_count          = "${var.nodes_count}"
  domain               = "${var.domain}"
}


module "inventory_generation" {
  source = "../modules/inventory_generation"

  master_domain = "${module.openshift_aws.master_domain}"
  node_domains = "${module.openshift_aws.node_domains}"
  apps_subdomain = "${module.openshift_aws.apps_subdomain}"
  master_ip_address = "${module.openshift_aws.master_ip_address}"
  node_ip_address = "${module.openshift_aws.node_ip_address}"
  private_key_path = "${var.private_key_path}"
  access_key = "${module.openshift_aws.access_key}"
  secret_key = "${module.openshift_aws.secret_key}"
  ansible_ssh_user = "centos"
  use_gluster = false
  provider = "aws"
}
