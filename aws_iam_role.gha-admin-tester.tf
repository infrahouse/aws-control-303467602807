locals {
  gha_admin_tester_role_name = "gha-admin-tester"
}

## Data Sources

data "aws_iam_policy_document" "gha-admin-tester-assume" {
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
        "repo:infrahouse/terraform-aws-gha-admin:*"
      ]
    }
  }
}

data "aws_iam_policy_document" "gha-admin-tester-permissions" {
  statement {
    actions = [
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
      "sts:AssumeRole",
      "sts:GetCallerIdentity"
    ]
    resources = ["*"]
  }
}

## EOF Data Sources

# IAM policy

resource "aws_iam_policy" "gha-admin-tester-permissions" {
  provider = aws.aws-303467602807-uw1
  name     = "${local.gha_admin_tester_role_name}-permissions"
  #  policy   = data.aws_iam_policy_document.gha-admin-tester-permissions.json
  policy = data.aws_iam_policy.administrator-access.policy
}

# IAM role

resource "aws_iam_role" "gha-admin-tester" {
  provider           = aws.aws-303467602807-uw1
  name               = local.gha_admin_tester_role_name
  description        = "Role to test module terraform-aws-gha-admin"
  assume_role_policy = data.aws_iam_policy_document.gha-admin-tester-assume.json
}

resource "aws_iam_role_policy_attachment" "gha-admin-tester" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.gha-admin-tester-permissions.arn
  role       = aws_iam_role.gha-admin-tester.name
}
