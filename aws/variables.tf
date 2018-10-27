variable "public_key_path" {
  default = "~/.ssh/tf.pub"
  description = "The local public key path, e.g. ~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  default = "~/.ssh/tf"
  description = "The local private key path, e.g. ~/.ssh/id_rsa"
}

variable "region" {
  default = "blr1"
  description = "The AWS region where the cluster will be spun."
}

variable "master_size" {
  default = "4gb"
  description = "Size of the master VM"
}

variable "node_size" {
  default = "4gb"
  description = "Size of the Node VMs"
}

variable "nodes_count" {
  default = 2
  description = "No. of app nodes to create."
}

variable "domain" {
  default = "example.com"
  description = "Base domain name for the Openshift cluster."
}
