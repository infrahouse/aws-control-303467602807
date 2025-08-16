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

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_ami" "ubuntu_pro_noble" {
  most_recent = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "state"
    values = [
      "available"
    ]
  }
  # --- Tag filters ---
  filter {
    name   = "tag:ubuntu_codename"
    values = ["noble"]
  }

  filter {
    name   = "tag:maintainer"
    values = ["infrahouse"]
  }
  owners = ["303467602807"] # InfraHouse
}
