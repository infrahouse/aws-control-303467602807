# IAM role
module "infrahouse-ubuntu-pro-github" {
  source  = "infrahouse/github-role/aws"
  version = "1.2.2"

  gh_org_name = "infrahouse"
  repo_name   = "infrahouse-ubuntu-pro"
}

data "aws_iam_policy_document" "infrahouse-ubuntu-pro-permissions" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeRegions",
      "sts:GetCallerIdentity",
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
    ]
    resources = [
      module.infrahouse-ubuntu-pro-uw-1.infrahouse-ubuntu-pro-param-arn
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:SetParameter",
    ]
    resources = module.infrahouse-ubuntu-pro-uw-1.infrahouse-ubuntu-pro-latest-image-arns
  }
}

resource "aws_iam_policy" "infrahouse-ubuntu-pro-permissions" {
  name_prefix = "infrahouse-ubuntu-pro-"
  policy      = data.aws_iam_policy_document.infrahouse-ubuntu-pro-permissions.json
}

resource "aws_iam_role_policy_attachment" "infrahouse-ubuntu-pro-permissions" {
  policy_arn = aws_iam_policy.infrahouse-ubuntu-pro-permissions.arn
  role       = module.infrahouse-ubuntu-pro-github.github_role_name
}


# region specific resources
module "infrahouse-ubuntu-pro-uw-1" {
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  source          = "./modules/infrahouse-ubuntu-pro-regional"
  environment     = local.environment
  github_role_arn = module.infrahouse-ubuntu-pro-github.github_role_arn
  subnet_id       = module.management.subnet_public_ids[0]
  supported_codenames = [
    "noble",
    "oracular"
  ]
}
