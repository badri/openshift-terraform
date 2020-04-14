data "aws_ami" "centos_7_x64" {
  most_recent = true

  owners = ["aws-marketplace"] // Centos account ID

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "product-code"
    values = ["aw0evgkw8e5c1q413zgy5pjce"]
  }


  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }
}
