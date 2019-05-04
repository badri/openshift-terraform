variable "key_name" {
  description = "The name of the key to user for ssh access, e.g: consul-cluster"
}

variable "public_key" {
  description = "The public key str"
}

variable "image" {
  description = "The base OS used for installation."
  default     = "fedora-28-x64-atomic"
}

variable "master_hostname" {
  description = "Hostname of Master."
  default     = "openshift-master"
}

variable "region" {
  description = "The region where the cluster will be spun"
  default     = "tor1"
}

variable "master_size" {
  description = "Size of the master"
  default     = "8gb"
}

variable "node_sizes" {
  description = "Size of the nodes"
  default     = ["4gb", "4gb"]
}

variable "node_regions" {
  description = "The region where the nodes will be created"
  default     = ["tor1", "tor1"]
}

variable "node_volume_sizes" {
  description = "Size of nodes' DO volumes in GB"
  default     = [50, 50]
}

variable "volume_size" {
  description = "Size of DO volumes in GB"
  default     = 50
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
