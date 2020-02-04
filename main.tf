module "openshift_digitalocean" {
  source            = "./openshift_digitalocean"
  key_name          = var.key_name
  public_key        = var.public_key
  region            = var.region
  master_size       = var.master_size
  node_sizes        = var.node_sizes
  node_volume_sizes = var.node_volume_sizes
  volume_size       = var.volume_size
  domain            = var.domain
  infra_size  = var.infra_size
}

