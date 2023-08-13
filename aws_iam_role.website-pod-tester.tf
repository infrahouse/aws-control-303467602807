locals {
  website_pod_tester_role_name = "website-pod-tester"
}

## Data Sources

data "aws_iam_policy_document" "website-pod-tester-assume" {
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
  statement {
    sid     = "010"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type = "Federated"
      identifiers = [
        module.github-connector.gh_openid_connect_provider_arn
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:infrahouse/terraform-aws-website-pod:*"
      ]
    }
  }
}

data "aws_iam_policy_document" "website-pod-tester-permissions" {
  statement {
    actions = [
      "acm:DescribeCertificate",
      "acm:ListTagsForCertificate",
      "acm:RequestCertificate",
      "autoscaling:CreateAutoScalingGroup",
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeScalingActivities",
      "ec2:CreateLaunchTemplate",
      "ec2:CreateTags",
      "ec2:DescribeImages",
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeInstanceCreditSpecifications",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeInstances",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeLaunchTemplates",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:ImportKeyPair",
      "ec2:RunInstances",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "iam:AddRoleToInstanceProfile",
      "iam:AttachRolePolicy",
      "iam:CreateInstanceProfile",
      "iam:CreatePolicy",
      "iam:CreateRole",
      "iam:CreateServiceLinkedRole",
      "iam:GetInstanceProfile",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole",
      "iam:ListAttachedRolePolicies",
      "iam:ListRolePolicies",
      "iam:PassRole",
      "route53:ChangeResourceRecordSets",
      "route53:GetChange",
      "route53:GetHostedZone",
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource"
    ]
    resources = ["*"]
  }
}

## EOF Data Sources

# IAM policy

resource "aws_iam_policy" "website-pod-tester-permissions" {
  provider = aws.aws-303467602807-uw1
  name     = "${local.website_pod_tester_role_name}-permissions"
  policy   = data.aws_iam_policy_document.website-pod-tester-permissions.json
}

# IAM role

resource "aws_iam_role" "website-pod-tester" {
  provider           = aws.aws-303467602807-uw1
  name               = local.website_pod_tester_role_name
  description        = "Role to test module terraform-aws-service-network"
  assume_role_policy = data.aws_iam_policy_document.website-pod-tester-assume.json
}

resource "aws_iam_role_policy_attachment" "website-pod-tester" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.website-pod-tester-permissions.arn
  role       = aws_iam_role.website-pod-tester.name
}

resource "aws_iam_role_policy_attachment" "website-pod-tester-sernive-network-permissions" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.service-network-tester-permissions.arn
  role       = aws_iam_role.website-pod-tester.name
}
