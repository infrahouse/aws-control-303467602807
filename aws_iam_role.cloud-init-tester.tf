module "github-role-tester" {
  source = "./modules/module-tester-role"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_org_name = "infrahouse"
  repo_name   = "terraform-aws-cloud-init"
  role_name   = "cloud-init-tester"
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  role_permissions = [
    "sts:GetCallerIdentity"
  ]
  grant_admin_permissions = false
}
