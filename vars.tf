variable "public_key" {
}

variable "region" {
}

variable "master_size" {
}

variable "infra_size" {
  type    = string
  default = null
}

variable "node_sizes" {
  type    = list(string)
  default = []
}

variable "domain" {
}

variable "key_name" {
}

variable "cluster_name" {
}

variable "cluster_id" {
}

variable "permitted_ip" {
}

