module "jumphost-tester" {
  source = "./modules/module-tester-role"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_org_name = "infrahouse"
  repo_name   = "terraform-aws-jumphost"
  role_name   = "jumphost-tester"
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  role_permissions = [
    # Initial
    "sts:AssumeRole",
    "sts:GetCallerIdentity",
    "route53:ListHostedZones",
    "ec2:DescribeAvailabilityZones",
    "ec2:DescribeKeyPairs",
    "ec2:DescribeImages",
    "iam:ListPolicies",
    "iam:GetRole",
    "iam:GetPolicy",

    # Plan permissions
    "autoscaling:DescribeAutoScalingGroups",
    "autoscaling:DescribeLifecycleHooks",
    "ec2:DescribeLaunchTemplateVersions",
    "ec2:DescribeLaunchTemplates",
    "events:DescribeRule",
    "events:ListTagsForResource",
    "events:ListTargetsByRule",
    "iam:GetInstanceProfile",
    "iam:GetPolicyVersion",
    "iam:ListAttachedRolePolicies",
    "iam:ListRolePolicies",
    "lambda:GetFunction",
    "lambda:GetFunctionCodeSigningConfig",
    "lambda:GetFunctionEventInvokeConfig",
    "lambda:GetPolicy",
    "lambda:ListVersionsByFunction",
    "logs:DescribeLogGroups",
    "logs:ListTagsLogGroup",
    "route53:GetHostedZone",
    "route53:ListTagsForResource",
    "s3:GetAccelerateConfiguration",
    "s3:GetBucketAcl",
    "s3:GetBucketCORS",
    "s3:GetBucketLogging",
    "s3:GetBucketObjectLockConfiguration",
    "s3:GetBucketPolicy",
    "s3:GetBucketPublicAccessBlock",
    "s3:GetBucketRequestPayment",
    "s3:GetBucketTagging",
    "s3:GetBucketVersioning",
    "s3:GetBucketWebsite",
    "s3:GetEncryptionConfiguration",
    "s3:GetLifecycleConfiguration",
    "s3:GetObject",
    "s3:GetObjectTagging",
    "s3:GetReplicationConfiguration",
    "s3:ListBucket",

    # Apply permissions
    "autoscaling:CreateAutoScalingGroup",
    "autoscaling:DescribeScalingActivities",
    "autoscaling:PutLifecycleHook",
    "ec2:CreateLaunchTemplate",
    "ec2:CreateTags",
    "ec2:ImportKeyPair",
    "events:PutRule",
    "events:PutTargets",
    "iam:AddRoleToInstanceProfile",
    "iam:AttachRolePolicy",
    "iam:CreateInstanceProfile",
    "iam:CreatePolicy",
    "iam:CreateRole",
    "iam:CreateServiceLinkedRole",
    "iam:PassRole",
    "lambda:AddPermission",
    "lambda:CreateFunction",
    "lambda:PutFunctionEventInvokeConfig",
    "logs:CreateLogGroup",
    "logs:PutRetentionPolicy",
    "s3:CompleteMultipartUpload",
    "s3:CreateBucket",
    "s3:CreateMultipartUpload",
    "s3:PutBucketTagging",
    "s3:UploadPart",

    # Destroy permissions
    "autoscaling:DeleteAutoScalingGroup",
    "autoscaling:DeleteLifecycleHook",
    "autoscaling:SetInstanceProtection",
    "autoscaling:UpdateAutoScalingGroup",
    "ec2:DeleteKeyPair",
    "ec2:DeleteLaunchTemplate",
    "events:DeleteRule",
    "events:RemoveTargets",
    "iam:DeleteInstanceProfile",
    "iam:DeletePolicy",
    "iam:DeleteRole",
    "iam:DetachRolePolicy",
    "iam:ListInstanceProfilesForRole",
    "iam:ListPolicyVersions",
    "iam:PassRole",
    "iam:RemoveRoleFromInstanceProfile",
    "lambda:DeleteFunction",
    "lambda:DeleteFunctionEventInvokeConfig",
    "lambda:RemovePermission",
    "logs:DeleteLogGroup",
    "s3:DeleteBucket",
    "s3:DeleteObject",
    "s3:PutBucketPublicAccessBlock"
  ]
  grant_admin_permissions = false
}

resource "aws_iam_role_policy_attachment" "jumphost-tester-admin-permissions" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.service-network-tester-permissions.arn
  role       = module.jumphost-tester.role_name
}
