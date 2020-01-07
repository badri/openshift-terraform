terraform {
  required_version = "~> 0.12"
}

provider "aws" {
  region  = var.region
}

module "openshift_aws" {
  source       = "./openshift_aws"
  key_name     = var.key_name
  public_key   = var.public_key
  region       = var.region
  master_size  = var.master_size
  node_sizes   = var.node_sizes
  domain       = var.domain
  cluster_name = var.cluster_name
  cluster_id   = var.cluster_id
}

output "bastion_ip_address" {
  value = module.openshift_aws.bastion_ip_address
}
