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
        local.me_arn,
        "arn:aws:iam::${local.home_account_id}:role/${local.service_network_tester_role_name}"
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
  provider = aws.aws-303467602807-uw1
  #  policy_arn = aws_iam_policy.state-bucket-tester-permissions.arn
  policy_arn = data.aws_iam_policy.administrator-access.arn
  role       = aws_iam_role.state-bucket-tester.name
}

resource "aws_iam_role_policy_attachment" "state-bucket-tester-pytest-permissions" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.pytest-permissions.arn
  role       = aws_iam_role.state-bucket-tester.name
}
