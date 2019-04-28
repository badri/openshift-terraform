output "master_domain" {
  value = "${format("%s.%s.shapeblock.cloud", var.console_subdomain, var.domain)}"
}

output "node_domains" {
  value = "${formatlist("%s.%s.shapeblock.cloud", aws_instance.nodes.*.tags.Name, var.domain)}"
}

output "master_ip_address" {
  value = "${aws_eip.master_eip.public_ip}"
}

output "node_ip_address" {
  value = "${aws_eip.node_eips.*.public_ip}"
}

output "apps_subdomain" {
  value = "${format("%s.%s.shapeblock.cloud", var.apps_subdomain, var.domain)}"
}
