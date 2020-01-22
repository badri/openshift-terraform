//  Collect together all of the output variables needed to build to the final
//  inventory from the inventory template.
data "template_file" "inventory" {
  template = file("${path.module}/inventory.template.cfg")
  vars = {
    access_key        = aws_iam_access_key.openshift-aws-user.id
    secret_key        = aws_iam_access_key.openshift-aws-user.secret
    public_hostname   = "console.${var.domain}.shapeblock.cloud"
    default_subdomain = "apps.${var.domain}.shapeblock.cloud"
    master_hostname   = aws_instance.master.public_dns
    infra_hostname   = aws_instance.infra.public_dns
    // TODO: add 1st node as infra node
    nodes = join(
      "\n",
      formatlist(
        "%s  openshift_node_group_name='node-config-compute' openshift_schedulable=true",
        aws_instance.nodes.*.public_dns))
    cluster_id = var.cluster_id
  }
}

//  Create the inventory.
resource "local_file" "inventory" {
  content  = data.template_file.inventory.rendered
  filename = "${path.cwd}/inventory.cfg"
}

