#locals {
#  jumphost_tester_role_name = "jumphost-tester"
#}
#
### Data Sources
#
#data "aws_iam_policy_document" "jumphost-tester-assume" {
#  statement {
#    sid     = "000"
#    actions = ["sts:AssumeRole"]
#    principals {
#      type = "AWS"
#      identifiers = [
#        local.me_arn,
#      ]
#    }
#  }
#  statement {
#    sid     = "010"
#    actions = ["sts:AssumeRoleWithWebIdentity"]
#    principals {
#      type = "Federated"
#      identifiers = [
#        module.github-connector.gh_openid_connect_provider_arn
#      ]
#    }
#    condition {
#      test     = "StringEquals"
#      variable = "token.actions.githubusercontent.com:aud"
#      values = [
#        "sts.amazonaws.com"
#      ]
#    }
#    condition {
#      test     = "StringLike"
#      variable = "token.actions.githubusercontent.com:sub"
#      values = [
#        "repo:infrahouse/terraform-aws-jumphost:*"
#      ]
#    }
#  }
#}
#
#data "aws_iam_policy_document" "jumphost-tester-permissions" {
#  statement {
#    actions = [
#      "sts:GetCallerIdentity"
#    ]
#    resources = ["*"]
#  }
#}
#
### EOF Data Sources
#
## IAM policy
#
#resource "aws_iam_policy" "jumphost-tester-permissions" {
#  provider = aws.aws-303467602807-uw1
#  name     = "${local.jumphost_tester_role_name}-permissions"
#  policy   = data.aws_iam_policy_document.jumphost-tester-permissions.json
#}
#
## IAM role
#
#resource "aws_iam_role" "jumphost-tester" {
#  provider           = aws.aws-303467602807-uw1
#  name               = local.jumphost_tester_role_name
#  description        = "Role to test module terraform-aws-jumphost"
#  assume_role_policy = data.aws_iam_policy_document.jumphost-tester-assume.json
#}
#
#resource "aws_iam_role_policy_attachment" "jumphost-tester" {
#  provider   = aws.aws-303467602807-uw1
#  policy_arn = aws_iam_policy.jumphost-tester-permissions.arn
#  role       = aws_iam_role.jumphost-tester.name
#}
#
#resource "aws_iam_role_policy_attachment" "jumphost-tester-admin-permissions" {
#  provider   = aws.aws-303467602807-uw1
#  policy_arn = data.aws_iam_policy.administrator-access.arn
#  role       = aws_iam_role.jumphost-tester.name
#}
