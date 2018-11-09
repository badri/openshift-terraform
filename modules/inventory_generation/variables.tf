variable "master_domain" {}

variable "node_domains" { type = "list" }

variable "master_ip_address" {}

variable "node_ip_address" {type = "list"}

variable "apps_subdomain" {}

variable "access_key" {}

variable "secret_key" {}

variable "use_gluster" {}

variable "provider" {}


variable "private_key_path" {
  description = "The local private key path, e.g. ~/.ssh/id_rsa"
}

variable "ansible_ssh_user" {
  description = "The ssh user for all the infrastructure nodes"
  default     = "root"
}

variable "pods_per_core" {
  description = "No. of k8s pods per core"
  default     = "10"
}
