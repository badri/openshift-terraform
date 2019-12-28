resource "random_password" "admin_password" {
  length = 16
  special = true
  override_special = "_%@"
}

data "template_file" "inventory" {
  template = file("${path.module}/inventory.template.cfg")
  vars = {
    public_hostname   = "console.${var.domain}.shapeblock.cloud"
    default_subdomain = "apps.${var.domain}.shapeblock.cloud"
    master_hostname  = digitalocean_droplet.master.0.ipv4_address_private
    infra_hostname   = digitalocean_droplet.nodes.0.ipv4_address_private
    bcrypt_passwd = bcrypt(random_password.admin_password.result)
    compute_nodes = join(
      "\n",
      formatlist(
        "%s openshift_schedulable=true openshift_node_group_name='node-config-compute'",
        slice(digitalocean_droplet.nodes.*.ipv4_address_private, 1, length(var.node_sizes)),
      ),
    )
  }
}

//  Create the inventory.
resource "local_file" "inventory" {
  content  = data.template_file.inventory.rendered
  filename = "${path.cwd}/inventory.cfg"
}
