module "tcp-pod-tester" {
  source = "./modules/module-tester-role"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_org_name = "infrahouse"
  repo_name   = "terraform-aws-tcp-pod"
  role_name   = "tcp-pod-tester"
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  grant_admin_permissions = true
}
