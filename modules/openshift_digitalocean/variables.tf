variable "key_name" {
  description = "The name of the key to user for ssh access, e.g: consul-cluster"
}

variable "public_key_path" {
  description = "The local public key path, e.g. ~/.ssh/id_rsa.pub"
}

variable "image" {
  description = "The base OS used for installation."
  default     = "centos-7-x64"
}

variable "master_hostname" {
  description = "Hostname of Master."
  default     = "openshift-master"
}

variable "region" {
  description = "The region where the cluster will be spun"
  default     = "blr1"
}

variable "master_size" {
  description = "Size of the master"
  default     = "4gb"
}

variable "node_size" {
  description = "Size of the nodes"
  default     = "4gb"
}

variable "nodes_count" {
  description = "No. of nodes"
  default     = 2
}

variable "volume_size" {
  description = "Size of DO volumes in GB"
  default     = 100
}

variable "domain" {
  description = "Base domain name for the cluster."
  default     = "trext.in"
}

// console.example.com
variable "console_subdomain" {
  default = "console"
}

// *.apps.example.com
variable "apps_subdomain" {
  default = "apps"
}

variable "node_prefix" {
  default = "node-"
}
