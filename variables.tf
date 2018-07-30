variable "public_key_path" {
  default = "~/.ssh/tf.pub"
}

variable "private_key_path" {
  default = "~/.ssh/tf"
}

variable "region" {
  default = "blr1"
}

variable "master_size" {
  default = "4gb"
}

variable "node_size" {
  default = "4gb"
}

variable "nodes_count" {
  default = 2
}

variable "volume_size" {
  default = 50
}

variable "domain" {
  default = "trext.in"
}
