## Data Sources

data "aws_iam_policy_document" "service-network-tester-assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::990466748045:user/aleks",
      ]
    }
  }
}

data "aws_iam_policy_document" "service-network-tester-permissions" {
  statement {
    actions = [
      "ec2:AllocateAddress",
      "ec2:AssociateRouteTable",
      "ec2:AttachInternetGateway",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateInternetGateway",
      "ec2:CreateNatGateway",
      "ec2:CreateRoute",
      "ec2:CreateRouteTable",
      "ec2:CreateSubnet",
      "ec2:CreateTags",
      "ec2:CreateVpc",
      "ec2:DeleteInternetGateway",
      "ec2:DeleteNatGateway",
      "ec2:DeleteRoute",
      "ec2:DeleteRouteTable",
      "ec2:DeleteSubnet",
      "ec2:DeleteVpc",
      "ec2:DescribeAddresses",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeNatGateways",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeRegions",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroupRules",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeVpcClassicLink",
      "ec2:DescribeVpcClassicLinkDnsSupport",
      "ec2:DescribeVpcs",
      "ec2:DetachInternetGateway",
      "ec2:DisassociateRouteTable",
      "ec2:ModifySubnetAttribute",
      "ec2:ReleaseAddress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "sts:AssumeRole",
      "sts:GetCallerIdentity"
    ]
    resources = ["*"]
  }
}

## EOF Data Sources

# IAM policy

resource "aws_iam_policy" "service-network-tester-permissions" {
  provider = aws.aws-303467602807-uw1
  name     = "service-network-tester-permissions"
  policy   = data.aws_iam_policy_document.service-network-tester-permissions.json
}

# IAM role

resource "aws_iam_role" "service-network-tester" {
  provider           = aws.aws-303467602807-uw1
  name               = "service-network-tester"
  description        = "Role to test module terraform-aws-service-network"
  assume_role_policy = data.aws_iam_policy_document.service-network-tester-assume.json
}

resource "aws_iam_role_policy_attachment" "service-network-tester" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.service-network-tester-permissions.arn
  role       = aws_iam_role.service-network-tester.name
}
