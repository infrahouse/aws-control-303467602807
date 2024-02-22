module "debian-repo-tester" {
  source = "./modules/module-tester-role"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_org_name = "infrahouse"
  repo_name   = "terraform-aws-debian-repo"
  role_name   = "debian-repo-tester"
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  role_permissions = distinct(
    concat(
      # Apply step
      [
        "acm:DescribeCertificate",
        "acm:ListTagsForCertificate",
        "acm:RequestCertificate",
        "cloudfront:CreateCachePolicy2020_05_31",
        "cloudfront:CreateDistributionWithTags2020_05_31",
        "cloudfront:CreateFunction2020_05_31",
        "cloudfront:DescribeFunction2020_05_31",
        "cloudfront:GetCachePolicy2020_05_31",
        "cloudfront:GetDistribution2020_05_31",
        "cloudfront:GetFunction2020_05_31",
        "cloudfront:ListTagsForResource2020_05_31",
        "cloudfront:PublishFunction2020_05_31",
        "route53:ChangeResourceRecordSets",
        "route53:GetChange",
        "route53:GetHostedZone",
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets",
        "route53:ListTagsForResource",
        "s3:CreateBucket",
        "s3:GetAccelerateConfiguration",
        "s3:GetBucketAcl",
        "s3:GetBucketCORS",
        "s3:GetBucketLocation",
        "s3:GetBucketLogging",
        "s3:GetBucketObjectLockConfiguration",
        "s3:GetBucketOwnershipControls",
        "s3:GetBucketPolicy",
        "s3:GetBucketPublicAccessBlock",
        "s3:GetBucketRequestPayment",
        "s3:GetBucketTagging",
        "s3:GetBucketVersioning",
        "s3:GetBucketWebsite",
        "s3:GetEncryptionConfiguration",
        "s3:GetLifecycleConfiguration",
        "s3:GetObjectTagging",
        "s3:GetReplicationConfiguration",
        "s3:HeadObject",
        "s3:ListBucket",
        "s3:PutBucketAcl",
        "s3:PutBucketOwnershipControls",
        "s3:PutBucketPolicy",
        "s3:PutBucketPublicAccessBlock",
        "s3:PutBucketTagging",
        "s3:PutBucketWebsite",
        "s3:PutObject",
        "secretsmanager:CreateSecret",
        "secretsmanager:DescribeSecret",
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:PutSecretValue",
        "sts:AssumeRole",
        "sts:GetCallerIdentity"
      ],
      # Destroy step
      [
        "acm:DeleteCertificate",
        "acm:DescribeCertificate",
        "acm:ListTagsForCertificate",
        "cloudfront:DeleteCachePolicy2020_05_31",
        "cloudfront:DeleteDistribution2020_05_31",
        "cloudfront:DeleteFunction2020_05_31",
        "cloudfront:DescribeFunction2020_05_31",
        "cloudfront:GetCachePolicy2020_05_31",
        "cloudfront:GetDistribution2020_05_31",
        "cloudfront:GetFunction2020_05_31",
        "cloudfront:ListTagsForResource2020_05_31",
        "cloudfront:UpdateDistribution2020_05_31",
        "route53:ChangeResourceRecordSets",
        "route53:GetChange",
        "route53:GetHostedZone",
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets",
        "route53:ListTagsForResource",
        "s3:DeleteBucket",
        "s3:DeleteBucketOwnershipControls",
        "s3:DeleteBucketPolicy",
        "s3:DeleteBucketWebsite",
        "s3:DeleteObject",
        "s3:GetAccelerateConfiguration",
        "s3:GetBucketAcl",
        "s3:GetBucketCORS",
        "s3:GetBucketLocation",
        "s3:GetBucketLogging",
        "s3:GetBucketObjectLockConfiguration",
        "s3:GetBucketOwnershipControls",
        "s3:GetBucketPolicy",
        "s3:GetBucketPublicAccessBlock",
        "s3:GetBucketRequestPayment",
        "s3:GetBucketTagging",
        "s3:GetBucketVersioning",
        "s3:GetBucketWebsite",
        "s3:GetEncryptionConfiguration",
        "s3:GetLifecycleConfiguration",
        "s3:GetObjectTagging",
        "s3:GetReplicationConfiguration",
        "s3:HeadObject",
        "s3:ListBucket",
        "s3:PutBucketPublicAccessBlock",
        "secretsmanager:DeleteSecret",
        "secretsmanager:DescribeSecret",
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "sts:AssumeRole",
        "sts:GetCallerIdentity"
      ]
    )
  )
  grant_admin_permissions = true
}
