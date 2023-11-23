module "ecs-tester" {
  source = "./modules/module-tester-role"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_org_name = "infrahouse"
  repo_name   = "terraform-aws-ecs"
  role_name   = "ecs-tester"
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  role_permissions = []
  grant_admin_permissions = true
}

resource "aws_iam_role_policy_attachment" "ecs-tester-service-network-permissions" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.service-network-tester-permissions.arn
  role       = module.ecs-tester.role_name
}

resource "aws_iam_role_policy_attachment" "ecs-tester-website-pod-permissions" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.website-pod-tester-permissions.arn
  role       = module.ecs-tester.role_name
}
