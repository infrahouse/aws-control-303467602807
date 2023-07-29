data "aws_iam_policy_document" "omnibus-assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::990466748045:user/aleks",
        "arn:aws:iam::493370826424:role/infrahouse-toolkit-github"
      ]
    }
  }
}

data "aws_iam_policy_document" "omnibus-permissions" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = [
      "${aws_s3_bucket.infrahouse-omnibus-cache.arn}/*"
    ]
  }
}

## EOF Data Sources

# IAM policy

resource "aws_iam_policy" "omnibus" {
  provider    = aws.aws-303467602807-uw1
  name_prefix = "omnibus"
  policy      = data.aws_iam_policy_document.omnibus-permissions.json
}

# IAM role

resource "aws_iam_role" "omnibus" {
  provider           = aws.aws-303467602807-uw1
  name               = "omnibus"
  description        = "Role that can use Omnibus artifacts"
  assume_role_policy = data.aws_iam_policy_document.omnibus-assume.json
}

resource "aws_iam_role_policy_attachment" "service-network-tester" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.omnibus.arn
  role       = aws_iam_role.omnibus.name
}
