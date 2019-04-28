variable "public_key" {}

variable "region" {}

variable "master_size" {}

variable "node_sizes" {
  type = "list"
}

variable "node_regions" {
  type = "list"
}

variable "node_volume_sizes" {
  type = "list"
}

variable "volume_size" {}

variable "domain" {}

variable "key_name" {}

variable "cluster_name" {}

variable "cluster_id" {}
