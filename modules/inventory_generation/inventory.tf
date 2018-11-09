// first, the interim inventory to run preconfigure playbook
data "template_file" "preinstall_inventory" {
  template = "${file("${path.module}/preinstall-inventory.template.cfg")}"

  vars {
    master_domain = "${var.master_domain}"
    node_domains  = "${join("\n", var.node_domains)}"
  }
}

//  Create the pre-install inventory.
resource "local_file" "preinstall_inventory" {
  content  = "${data.template_file.preinstall_inventory.rendered}"
  filename = "${path.cwd}/preinstall-inventory.cfg"
}

// Create openshift's inventory
data "template_file" "inventory" {
  template = "${file("${path.module}/inventory.template.cfg")}"

  vars {
    master_ips                         = "${format("%s openshift_ip=%s openshift_schedulable=true", var.master_ip_address, var.master_ip_address)}"
    etcd_ips                           = "${format("%s openshift_ip=%s", var.master_ip_address, var.master_ip_address)}"
    master_node_entry                  = "${format("%s openshift_ip=%s openshift_schedulable=true openshift_node_group_name='node-config-all-in-one'", var.master_ip_address, var.master_ip_address)}"
    nodes                              = "${join("\n", formatlist("%s openshift_ip=%s openshift_schedulable=true openshift_node_group_name='node-config-compute'", var.node_ip_address, var.node_ip_address))}"
    glusterfs_master                   = "${format("%s glusterfs_devices='[ \"/dev/sda\" ]'", var.master_ip_address)}"
    glusterfs_nodes                    = "${join("\n", formatlist("%s glusterfs_devices='[ \"/dev/sda\" ]'", var.node_ip_address))}"
    ansible_ssh_user                   = "${var.ansible_ssh_user}"
    private_key_path                   = "${var.private_key_path}"
    pods_per_core                      = "${var.pods_per_core}"
    openshift_public_host_name         = "${var.master_domain}"
    openshift_master_default_subdomain = "${var.apps_subdomain}"
    access_key = "${var.access_key}" # good candidate for go templates
    secret_key = "${var.secret_key}"
  }
}

resource "local_file" "inventory" {
  content  = "${data.template_file.inventory.rendered}"
  filename = "${path.cwd}/inventory.cfg"
}
