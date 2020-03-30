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

variable "node_volume_sizes" {
  type = list(string)
}

variable "volume_size" {
}

variable "domain" {
}

variable "key_name" {
}

