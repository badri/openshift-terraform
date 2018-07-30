// first, the interim inventory to run preconfigure playbook
data "template_file" "preinstall_inventory" {
  template = "${file("${path.module}/preinstall-inventory.template.cfg")}"

  vars {
    master_domain = "${var.console_subdomain}.${var.domain}"
    node_domains  = "${join("\n", formatlist("%s.%s", digitalocean_droplet.nodes.*.name, var.domain))}"
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
    master_ips                         = "${format("%s openshift_ip=%s openshift_schedulable=true", digitalocean_droplet.master.ipv4_address, digitalocean_droplet.master.ipv4_address)}"
    etcd_ips                           = "${format("%s openshift_ip=%s", digitalocean_droplet.master.ipv4_address, digitalocean_droplet.master.ipv4_address)}"
    master_node_entry                  = "${format("%s openshift_ip=%s openshift_schedulable=true openshift_node_labels=\"{'region': 'primary', 'zone': 'east'}\"", digitalocean_droplet.master.ipv4_address, digitalocean_droplet.master.ipv4_address)}"
    nodes                              = "${join("\n", formatlist("%s openshift_ip=%s openshift_schedulable=true openshift_node_labels=\"{'region': 'primary', 'zone': 'east'}\"", digitalocean_droplet.nodes.*.ipv4_address, digitalocean_droplet.nodes.*.ipv4_address))}"
    glusterfs_master                   = "${format("%s glusterfs_devices='[ \"/dev/sda\" ]'", digitalocean_droplet.master.ipv4_address)}"
    glusterfs_nodes                    = "${join("\n", formatlist("%s glusterfs_devices='[ \"/dev/sda\" ]'", digitalocean_droplet.nodes.*.ipv4_address))}"
    ansible_ssh_user                   = "${var.ansible_ssh_user}"
    private_key_path                   = "${var.private_key_path}"
    pods_per_core                      = "${var.pods_per_core}"
    openshift_public_host_name         = "${format("%s.%s", var.console_subdomain, var.domain)}"
    openshift_master_default_subdomain = "${format("%s.%s", var.apps_subdomain, var.domain)}"
  }
}

resource "local_file" "inventory" {
  content  = "${data.template_file.inventory.rendered}"
  filename = "${path.cwd}/inventory.cfg"
}
