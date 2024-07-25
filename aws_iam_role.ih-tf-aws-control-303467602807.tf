# Roles for CI/CD in the aws-control-303467602807 repo

module "ih-tf-aws-control-303467602807-admin" {
  source  = "infrahouse/gha-admin/aws"
  version = "3.5.0"
  providers = {
    aws          = aws.aws-303467602807-uw1
    aws.cicd     = aws.aws-303467602807-uw1
    aws.tfstates = aws.tfstates

  }
  gh_identity_provider_arn  = module.github-connector.gh_openid_connect_provider_arn
  repo_name                 = "aws-control-303467602807"
  state_bucket              = "infrahouse-aws-control-303467602807"
  gh_org_name               = "infrahouse"
  terraform_locks_table_arn = ""
}


data "aws_iam_policy_document" "ih-tf-aws-control-303467602807-read-only-assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::990466748045:user/aleks",
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
