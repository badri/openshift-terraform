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
    master_hostname  = digitalocean_droplet.master.0.ipv4_address
    infra_hostname   = digitalocean_droplet.infra.0.ipv4_address
    bcrypt_passwd = bcrypt(random_password.admin_password.result)
    compute_nodes = join(
      "\n",
      formatlist(
        "%s openshift_node_group_name='node-config-compute' openshift_schedulable=true",
        digitalocean_droplet.nodes.*.ipv4_address))
  }
}

//  Create the inventory.
resource "local_file" "inventory" {
  content  = data.template_file.inventory.rendered
  filename = "${path.cwd}/inventory.cfg"
}
