module "gha-admin-tester" {
  source = "./modules/module-tester-role"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_org_name = "infrahouse"
  repo_name   = "terraform-aws-gha-admin"
  role_name   = "gha-admin-tester"
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  role_permissions = [
    "dynamodb:CreateTable",
    "dynamodb:DeleteTable",
    "dynamodb:DescribeContinuousBackups",
    "dynamodb:DescribeTable",
    "dynamodb:DescribeTimeToLive",
    "dynamodb:ListTagsOfResource",
    "dynamodb:TagResource",
    "iam:AttachRolePolicy",
    "iam:CreatePolicy",
    "iam:CreateRole",
    "iam:DeletePolicy",
    "iam:DeleteRole",
    "iam:DetachRolePolicy",
    "iam:GetOpenIDConnectProvider",
    "iam:GetPolicy",
    "iam:GetPolicyVersion",
    "iam:GetRole",
    "iam:ListAttachedRolePolicies",
    "iam:ListInstanceProfilesForRole",
    "iam:ListOpenIDConnectProviders",
    "iam:ListPolicies",
    "iam:ListPolicyVersions",
    "iam:ListRolePolicies",
    "iam:TagPolicy",
    "iam:TagRole",
    "s3:CreateBucket",
    "s3:DeleteBucket",
    "s3:GetAccelerateConfiguration",
    "s3:GetBucketAcl",
    "s3:GetBucketCORS",
    "s3:GetBucketLogging",
    "s3:GetBucketObjectLockConfiguration",
    "s3:GetBucketPolicy",
    "s3:GetBucketRequestPayment",
    "s3:GetBucketTagging",
    "s3:GetBucketVersioning",
    "s3:GetBucketWebsite",
    "s3:GetEncryptionConfiguration",
    "s3:GetLifecycleConfiguration",
    "s3:GetReplicationConfiguration",
    "s3:ListBucket",
    "s3:PutBucketTagging",
    "sts:AssumeRole",
    "sts:GetCallerIdentity"
  ]
  grant_admin_permissions = false
}

resource "aws_iam_role_policy_attachment" "gha-admin-tester-pytest-permissions" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.pytest-permissions.arn
  role       = module.gha-admin-tester.role_name
}
