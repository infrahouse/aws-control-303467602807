resource "aws_iam_policy" "pytest-permissions" {
  provider = aws.aws-303467602807-uw1
  name     = "pytest-permissions"
  policy   = data.aws_iam_policy_document.pytest-permissions.json
}
