module "github-role-tester" {
  source      = "./modules/module-tester-role"
  gh_org_name = "infrahouse"
  repo_name   = "terraform-aws-github-role"
  role_name   = "github-role-tester"
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  role_permissions        = []
  grant_admin_permissions = true
}
