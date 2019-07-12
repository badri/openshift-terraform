variable "key_name" {
  description = "The name of the key to user for ssh access, e.g: consul-cluster"
}

variable "public_key" {
  description = "The public key str"
}

variable "region" {
  default     = "us-east-1"
  description = "The AWS region where the cluster will be spun."
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "subnetaz" {
  type = "map"

  default = {
    us-east-1      = "us-east-1a"
    us-east-2      = "us-east-2a"
    us-west-1      = "us-west-1a"
    us-west-2      = "us-west-2a"
    eu-west-1      = "eu-west-1a"
    eu-west-2      = "eu-west-2a"
    eu-central-1   = "eu-central-1a"
    ap-southeast-1 = "ap-southeast-1a"
  }
}

variable "master_size" {
  default     = "m5.xlarge"
  description = "Size of the master VM"
}

variable "node_sizes" {
  description = "Size of the nodes"
  default     = ["m5.large", "m5.large"]
}

variable "node_prefix" {
  default = "node-"
}

variable "domain" {
  default     = "example.com"
  description = "Base domain name for the Openshift cluster."
}

// console.example.com
variable "console_subdomain" {
  default = "console"
}

// *.apps.example.com
variable "apps_subdomain" {
  default = "apps"
}

variable "cluster_name" {
  description = "Name of the cluster, e.g: 'openshift-cluster'. Useful when running multiple clusters in the same AWS account."
}

variable "cluster_id" {
  description = "ID of the cluster, e.g: 'openshift-cluster-us-east-1'. Useful when running multiple clusters in the same AWS account."
}
