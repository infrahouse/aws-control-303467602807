# CI/CD roles (gha-admin, state-manager) are now managed by the aws-control repo.
# Only the read-only role remains here.

data "aws_iam_policy_document" "ih-tf-aws-control-303467602807-read-only-assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        local.sso_admin_arn,
        "arn:aws:iam::493370826424:role/ih-tf-aws-control-493370826424-github"
      ]
    }
  }
}

resource "aws_iam_role" "ih-tf-aws-control-303467602807-read-only" {
  provider           = aws.aws-303467602807-uw1
  name               = "ih-tf-aws-control-303467602807-read-only"
  description        = "Role to provide read-only access to terraform in 493370826424 account"
  assume_role_policy = data.aws_iam_policy_document.ih-tf-aws-control-303467602807-read-only-assume.json
}
resource "aws_iam_role_policy_attachment" "ih-tf-aws-control-303467602807-read-only" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = data.aws_iam_policy.read-only-access.arn
  role       = aws_iam_role.ih-tf-aws-control-303467602807-read-only.name
}
