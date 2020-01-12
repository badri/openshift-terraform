locals {
  common_tags = {
    "KubernetesCluster"                         = var.cluster_name
    "kubernetes.io/cluster/${var.cluster_name}" = var.cluster_id
  }
}

// master
resource "aws_eip" "master_eip" {
  instance = aws_instance.master.id
  vpc      = true
}

// infra node
resource "aws_eip" "infra_eip" {
  instance = aws_instance.nodes.0.id
  vpc      = true
}

resource "aws_instance" "master" {
  ami = data.aws_ami.centos_7_x64.id

  # Master nodes require at least 16GB of memory.
  instance_type        = var.master_size
  subnet_id            = aws_subnet.public-subnet.id
  iam_instance_profile = aws_iam_instance_profile.openshift-instance-profile.id

  vpc_security_group_ids = [
    aws_security_group.openshift-vpc.id,
    aws_security_group.openshift-public-ingress.id,
    aws_security_group.openshift-public-egress.id,
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  key_name = aws_key_pair.keypair.key_name

  tags = merge(
    local.common_tags,
    {
      "Name" = "openShift-master"
    },
  )
}

// nodes
resource "aws_instance" "nodes" {
  ami                  = data.aws_ami.centos_7_x64.id
  instance_type        = var.node_sizes[count.index]
  subnet_id            = aws_subnet.public-subnet.id
  iam_instance_profile = aws_iam_instance_profile.openshift-instance-profile.id

  vpc_security_group_ids = [
    aws_security_group.openshift-vpc.id,
    aws_security_group.openshift-public-ingress.id,
    aws_security_group.openshift-public-egress.id,
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  key_name = aws_key_pair.keypair.key_name

  count = length(var.node_sizes)

  tags = merge(
    local.common_tags,
    {
      "Name" = format("%s%02d", var.node_prefix, count.index + 1)
    },
  )
}
