module "debian-repo-tester" {
  source = "./modules/module-tester-role"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_org_name = "infrahouse"
  repo_name   = "terraform-aws-debian-repo"
  role_name   = "debian-repo-tester"
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  role_permissions        = []
  grant_admin_permissions = true
}
