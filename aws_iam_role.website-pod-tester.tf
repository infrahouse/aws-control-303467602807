module "website-pod-tester" {
  source = "./modules/module-tester-role"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_org_name = "infrahouse"
  repo_name   = "terraform-aws-website-pod"
  role_name   = "website-pod-tester"
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  role_permissions        = [
    "acm:DeleteCertificate",
    "acm:DescribeCertificate",
    "acm:ListTagsForCertificate",
    "acm:RequestCertificate",
    "autoscaling:CreateAutoScalingGroup",
    "autoscaling:DeleteAutoScalingGroup",
    "autoscaling:DeletePolicy",
    "autoscaling:DescribeAutoScalingGroups",
    "autoscaling:DescribeInstanceRefreshes",
    "autoscaling:DescribePolicies",
    "autoscaling:DescribeScalingActivities",
    "autoscaling:PutScalingPolicy",
    "autoscaling:SetInstanceProtection",
    "autoscaling:UpdateAutoScalingGroup",
    "ec2:CreateLaunchTemplate",
    "ec2:CreateTags",
    "ec2:DeleteKeyPair",
    "ec2:DeleteLaunchTemplate",
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
    "ec2:DetachNetworkInterface",
    "ec2:ImportKeyPair",
    "ec2:ModifyInstanceAttribute",
    "ec2:RunInstances",
    "ec2:TerminateInstances",
    "elasticloadbalancing:AddTags",
    "elasticloadbalancing:CreateListener",
    "elasticloadbalancing:CreateLoadBalancer",
    "elasticloadbalancing:CreateTargetGroup",
    "elasticloadbalancing:DeleteListener",
    "elasticloadbalancing:DeleteLoadBalancer",
    "elasticloadbalancing:DeleteTargetGroup",
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
    "iam:DeleteInstanceProfile",
    "iam:DeletePolicy",
    "iam:DeleteRole",
    "iam:DetachRolePolicy",
    "iam:GetInstanceProfile",
    "iam:GetPolicy",
    "iam:GetPolicyVersion",
    "iam:GetRole",
    "iam:ListAttachedRolePolicies",
    "iam:ListInstanceProfilesForRole",
    "iam:ListPolicyVersions",
    "iam:ListRolePolicies",
    "iam:PassRole",
    "iam:RemoveRoleFromInstanceProfile",
    "route53:ChangeResourceRecordSets",
    "route53:GetChange",
    "route53:GetHostedZone",
    "route53:ListHostedZones",
    "route53:ListHostedZonesByName",
    "route53:ListResourceRecordSets",
    "route53:ListTagsForResource",
  ]
  grant_admin_permissions = true
}

resource "aws_iam_role_policy_attachment" "website-pod-tester-sernive-network-permissions" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.service-network-tester-permissions.arn
  role       = module.website-pod-tester.role_name
}
