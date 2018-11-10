variable "key_name" {
  default = "openshift"
  description = "The name of the key to user for ssh access, e.g: consul-cluster"
}

variable "public_key_path" {
  default = "~/.ssh/tf.pub"
  description = "The local public key path, e.g. ~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  default = "~/.ssh/tf"
  description = "The local private key path, e.g. ~/.ssh/id_rsa"
}

variable "region" {
  default = "us-east-1"
  description = "The AWS region where the cluster will be spun."
}

variable "master_size" {
  default = "m5.xlarge"
}

variable "node_size" {
  default = "m5.large"
}

variable "nodes_count" {
  default     = 1
}


variable "domain" {
  default = "example.com"
  description = "Base domain name for the Openshift cluster."
}
