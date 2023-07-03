# Roles for CI/CD in the aws-control-303467602807 repo

module "ih-tf-aws-control-303467602807-admin" {
  source = "github.com/infrahouse/terraform-aws-gha-admin"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_identity_provider_arn = module.github-connector.gh_openid_connect_provider_arn
  repo_name                = "aws-control-303467602807"
  state_bucket             = "infrahouse-aws-control-303467602807"
}
