## Data Sources

data "aws_iam_policy_document" "ih-tf-ih-cicd-control-assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::289256138624:role/ih-tf-github-control"
      ]
    }
  }
}

## EOF Data Sources


# IAM role ih-tf-cicd-control

resource "aws_iam_role" "ih-tf-cicd-control" {
  provider           = aws.aws-303467602807-uw1
  name               = "ih-tf-cicd-control"
  description        = "Role to manage 303467602807 with Terraform"
  assume_role_policy = data.aws_iam_policy_document.ih-tf-ih-cicd-control-assume.json
}

resource "aws_iam_role_policy_attachment" "ih-tf-cicd-control" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = data.aws_iam_policy.administrator-access.arn
  role       = aws_iam_role.ih-tf-cicd-control.name
}
