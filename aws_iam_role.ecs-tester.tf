module "ecs-tester" {
  source = "./modules/module-tester-role"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_org_name          = "infrahouse"
  repo_name            = "terraform-aws-ecs"
  role_name            = "ecs-tester"
  max_session_duration = 12 * 3600
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  role_permissions        = []
  grant_admin_permissions = true
}

resource "aws_iam_role_policy_attachment" "ecs-tester-service-network-permissions" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = module.service-network-tester.permissions_policy_arn
  role       = module.ecs-tester.role_name
}

resource "aws_iam_role_policy_attachment" "ecs-tester-website-pod-permissions" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = module.website-pod-tester.permissions_policy_arn
  role       = module.ecs-tester.role_name
}
