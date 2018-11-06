data "aws_ami" "centos_7_x64" {
  most_recent = true

  owners = ["679593333241"] // Centos account ID

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }
}

output "ami_id" {
  value = "${data.aws_ami.centos_7_x64.image_id}"
}
