data "aws_iam_policy" "administrator-access" {
  provider = aws.aws-303467602807-uw1
  name     = "AdministratorAccess"
}

data "aws_iam_policy" "read-only-access" {
  provider = aws.aws-303467602807-uw1
  name     = "ReadOnlyAccess"
}


# Common permissions for pytest fixtures
# used ny terraform unit tests
data "aws_iam_policy_document" "pytest-permissions" {
  provider = aws.aws-303467602807-uw1
  statement {
    actions = [
      "ec2:DescribeRegions",
    ]
    resources = ["*"]
  }
}
