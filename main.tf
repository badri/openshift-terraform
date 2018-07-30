// module openshift digitalocean - done

// spin master and nodes - done

// configure domains - done

// add volumes - done

// preinstall - done

// generate inventory - done

// submodule

// setup

// postinstall - create users

// readme

// makefile(??)

// -----------------------

// split into 2 modules.
// one for creating infra, another for generating inventory.
// use golang template plugin for inventory generation

// glusterFS or NFS?

// docker storage(??)

// add another module for openshift azure

// openshift AWS

// openshift google cloud

// works with 3.9

// configure for high availability

// TLS for console

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
