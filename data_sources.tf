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
      "dynamodb:ListTagsOfResource",
      "dynamodb:TagResource",
      "ec2:DescribeRegions",
      "iam:TagPolicy",
      "iam:TagRole",
      "s3:GetBucketTagging",
      "s3:PutBucketTagging"
    ]
    resources = ["*"]
  }
}

data "aws_availability_zones" "uw1" {
  state = "available"
}
