## Data Sources

data "aws_iam_policy_document" "service-network-tester-assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::990466748045:user/aleks",
      ]
    }
  }
}

data "aws_iam_policy_document" "service-network-tester-permissions" {
  statement {
    actions = [
      "ec2:CreateTags",
      "ec2:CreateVpc",
      "ec2:DeleteVpc"
    ]
    resources = ["*"]
  }
}

## EOF Data Sources

# IAM policy

resource "aws_iam_policy" "service-network-tester-permissions" {
  name   = "service-network-tester-permissions"
  policy = data.aws_iam_policy_document.service-network-tester-permissions.json
}

# IAM role

resource "aws_iam_role" "service-network-tester" {
  provider           = aws.aws-303467602807-uw1
  name               = "service-network-tester"
  description        = "Role to test module terraform-aws-service-network"
  assume_role_policy = data.aws_iam_policy_document.service-network-tester-assume.json
}

resource "aws_iam_role_policy_attachment" "service-network-tester" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.service-network-tester-permissions.arn
  role       = aws_iam_role.service-network-tester.name
}
