output "master_domain" {
  value = "${var.console_subdomain}.${var.domain}"
}

output "node_domains" {
  value = "${formatlist("%s.%s", aws_instance.nodes.*.tags.Name, var.domain)}"
}

output "master_ip_address" {
  value = "${aws_eip.master_eip.public_ip}"
}

output "node_ip_address" {
  value = "${aws_eip.node_eips.*.public_ip}"
}

output "apps_subdomain" {
  value = "${var.apps_subdomain}.${var.domain}"
}

output "access_key" {
  value = "${aws_iam_access_key.openshift-aws-user.id}"
}

output "secret_key" {
  value = "${aws_iam_access_key.openshift-aws-user.secret}"
}
