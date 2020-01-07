resource "aws_iam_role" "openshift-instance-role" {
  name = "openshift-instance-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF

}

resource "aws_iam_user" "openshift-aws-user" {
  name = "openshift-aws-user"
}

resource "aws_iam_user_policy" "openshift-aws-user" {
  name = "openshift-aws-user-policy"
  user = aws_iam_user.openshift-aws-user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeVolume*",
        "ec2:CreateVolume",
        "ec2:CreateTags",
        "ec2:DescribeInstance*",
        "ec2:AttachVolume",
        "ec2:DetachVolume",
        "ec2:DeleteVolume",
        "ec2:DescribeSubnets",
        "ec2:CreateSecurityGroup",
        "ec2:DescribeSecurityGroups",
        "elasticloadbalancing:DescribeTags",
        "elasticloadbalancing:CreateLoadBalancerListeners",
        "ec2:DescribeRouteTables",
        "elasticloadbalancing:ConfigureHealthCheck",
        "ec2:AuthorizeSecurityGroupIngress",
        "elasticloadbalancing:DeleteLoadBalancerListeners",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:CreateLoadBalancer",
        "elasticloadbalancing:DeleteLoadBalancer",
        "elasticloadbalancing:ModifyLoadBalancerAttributes",
        "elasticloadbalancing:DescribeLoadBalancerAttributes"
      ],
      "Resource": "*"
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "bastion-instance-profile" {
  name  = "bastion-instance-profile"
  role = aws_iam_role.openshift-instance-role.name
}

resource "aws_iam_access_key" "openshift-aws-user" {
  user = aws_iam_user.openshift-aws-user.name
}

resource "aws_iam_instance_profile" "openshift-instance-profile" {
  name = "openshift-instance-profile"
  role = aws_iam_role.openshift-instance-role.name
}

