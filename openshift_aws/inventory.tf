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
    infra_hostname    = var.infra_size != null ? aws_instance.infra[0].public_dns : ""
    stage_two         = var.infra_size == null && length(var.node_sizes) >= 1 ? true : false
    free_tier         = var.infra_size != null ? false : true
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

