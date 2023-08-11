data "aws_iam_policy" "administrator-access" {
  provider = aws.aws-303467602807-uw1
  name     = "AdministratorAccess"
}

data "aws_iam_policy" "read-only-access" {
  provider = aws.aws-303467602807-uw1
  name     = "ReadOnlyAccess"
}
