resource "aws_route53_zone" "openshift_route53_zone" {
  name = "${var.domain}"
}

// Master record
resource "aws_route53_record" "openshift-master-record" {
    zone_id = "${aws_route53_zone.openshift_route53_zone.zone_id}"
    name = "console"
    type = "A"
    ttl  = 300
    records = [
        "${aws_eip.master_eip.public_ip}"
    ]
}

// Node records
resource "aws_route53_record" "openshift-node-records" {
  zone_id = "${aws_route53_zone.openshift_route53_zone.zone_id}"
  name   = "${format("%s%02d", var.node_prefix, count.index + 1)}"
  type = "A"
  ttl  = 300
  records = [
    "${element(aws_eip.node_eips.*.public_ip, count.index)}"
  ]
  count  = "${var.nodes_count}"
}

// apps subdomain
resource "aws_route53_record" "openshift-app-subdomain" {
  zone_id = "${aws_route53_zone.openshift_route53_zone.zone_id}"
  name   = "*.apps"
  type = "CNAME"
  ttl  = 300
  records = [
    "${var.domain}" # should be console subdomain.domain
  ]
}
/*
output "nameservers" {
  value = "${aws_route53_zone.openshift_route53_zone.name_servers}"
}
*/
