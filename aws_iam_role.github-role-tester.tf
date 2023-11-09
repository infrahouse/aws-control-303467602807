module "github-role-tester" {
  source = "./modules/module-tester-role"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_org_name = "infrahouse"
  repo_name   = "terraform-aws-github-role"
  role_name   = "github-role-tester"
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  role_permissions = [
    "iam:CreateRole",
    "iam:DeleteRole",
    "iam:GetOpenIDConnectProvider",
    "iam:GetRole",
    "iam:ListAttachedRolePolicies",
    "iam:ListInstanceProfilesForRole",
    "iam:ListOpenIDConnectProviders",
    "iam:ListRolePolicies",
    "sts:AssumeRole",
    "sts:GetCallerIdentity"
  ]
  grant_admin_permissions = false
}
