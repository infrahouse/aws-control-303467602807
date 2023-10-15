locals {
  state_bucket_tester_role_name = "state-bucket-tester"
}

## Data Sources

data "aws_iam_policy_document" "state-bucket-tester-assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        local.me_arn
      ]
    }
  }
  statement {
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
        "repo:infrahouse/terraform-aws-state-bucket:*"
      ]
    }
  }
}

data "aws_iam_policy_document" "state-bucket-tester-permissions" {
  statement {
    actions = [
      "dynamodb:CreateTable",
      "dynamodb:DeleteTable",
      "dynamodb:DescribeContinuousBackups",
      "dynamodb:DescribeTable",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:ListTagsOfResource",
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:DeletePublicAccessBlock",
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
      "s3:GetPublicAccessBlock",
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
      "s3:PutBucketTagging",
      "s3:PutPublicAccessBlock",
      "sts:AssumeRole",
      "sts:GetCallerIdentity"
    ]
    resources = ["*"]
  }
}

## EOF Data Sources

# IAM policy

resource "aws_iam_policy" "state-bucket-tester-permissions" {
  provider = aws.aws-303467602807-uw1
  name     = "${local.state_bucket_tester_role_name}-permissions"
  policy   = data.aws_iam_policy_document.state-bucket-tester-permissions.json
}

# IAM role

resource "aws_iam_role" "state-bucket-tester" {
  provider           = aws.aws-303467602807-uw1
  name               = local.state_bucket_tester_role_name
  description        = "Role to test module terraform-aws-gha-admin"
  assume_role_policy = data.aws_iam_policy_document.state-bucket-tester-assume.json
}

resource "aws_iam_role_policy_attachment" "state-bucket-tester" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.state-bucket-tester-permissions.arn
  role       = aws_iam_role.state-bucket-tester.name
}

resource "aws_iam_role_policy_attachment" "state-bucket-tester-pytest-permissions" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.pytest-permissions.arn
  role       = aws_iam_role.state-bucket-tester.name
}
