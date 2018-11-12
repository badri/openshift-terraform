locals {
  aws_keys_block = <<EOF
openshift_cloudprovider_kind=aws
openshift_cloudprovider_aws_access_key=%s
openshift_cloudprovider_aws_secret_key=%s
EOF
}

// Create openshift's inventory
data "template_file" "inventory" {
  template = "${file("${path.module}/inventory.template.cfg")}"

  vars {
    master_ips                         = "${format("%s openshift_ip=%s openshift_schedulable=true", var.master_domain, var.master_ip_address)}"
    etcd_ips                           = "${format("%s openshift_ip=%s", var.master_domain, var.master_ip_address)}"
    master_node_entry                  = "${format("%s openshift_ip=%s openshift_schedulable=true openshift_node_group_name='node-config-all-in-one'", var.master_domain, var.master_ip_address)}"
    nodes                              = "${join("\n", formatlist("%s openshift_ip=%s openshift_schedulable=true openshift_node_group_name='node-config-compute'", var.node_domains, var.node_ip_address))}"
    gluster_group = "${var.use_gluster?"glusterfs":""}"
    glusterfs_master                   = "${var.use_gluster?format("[glusterfs]\n%s glusterfs_devices='[ \"/dev/sda\" ]'", var.master_domain):""}"
    glusterfs_nodes                    = "${var.use_gluster?join("\n", formatlist("%s glusterfs_devices='[ \"/dev/sda\" ]'", var.node_domains)):""}"
    ansible_ssh_user                   = "${var.ansible_ssh_user}"
    private_key_path                   = "${var.private_key_path}"
    pods_per_core                      = "${var.pods_per_core}"
    openshift_public_host_name         = "${var.master_domain}"
    openshift_master_default_subdomain = "${var.apps_subdomain}"
    cluster_id = "${var.cluster_id}"
    aws_keys_block = "${var.provider == "aws"?format(local.aws_keys_block, var.access_key, var.secret_key):""}"
  }
}

resource "local_file" "inventory" {
  content  = "${data.template_file.inventory.rendered}"
  filename = "${path.cwd}/inventory.cfg"
}
