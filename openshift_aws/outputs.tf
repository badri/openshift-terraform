output "master_domain" {
  value = format("console.%s.shapeblock.cloud", var.domain)
}

output "master_ip_address" {
  value = aws_eip.master_eip.public_ip
}

output "apps_subdomain" {
  value = format("*.apps.%s.shapeblock.cloud", var.domain)
}

output "bastion_ip_address" {
  value = aws_eip.bastion_eip.public_ip
}
