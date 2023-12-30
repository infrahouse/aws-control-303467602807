module "jumphost-tester" {
  source = "./modules/module-tester-role"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_org_name = "infrahouse"
  repo_name   = "terraform-aws-jumphost"
  role_name   = "jumphost-tester"
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  role_permissions = [
    "sts:AssumeRole",
    "sts:GetCallerIdentity"
  ]
  grant_admin_permissions = false
}

resource "aws_iam_role_policy_attachment" "jumphost-tester-admin-permissions" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.service-network-tester-permissions.arn
  role       = module.jumphost-tester.role_name
}
