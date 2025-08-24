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
      "ec2:CreateImage",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeRegions",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVolumes",
      "ec2:RunInstances",
      "sts:GetCallerIdentity",
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:DeregisterImage",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/created_by"
      values   = ["infrahouse-ubuntu-pro"]
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateTags",
    ]
    resources = [
      "arn:aws:ec2:${data.aws_region.current.name}::image/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:snapshot/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*",
      "arn:aws:ec2:${data.aws_region.current.name}::snapshot/*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
    ]
    resources = [
      module.infrahouse-ubuntu-pro-uw-1.infrahouse-ubuntu-pro-param-arn,
      "arn:aws:ssm:${data.aws_region.current.name}::parameter/aws/service/canonical/*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:PutParameter",
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

# Prevent making AMIs publicly accessible in the region and account for which the provider is configured
resource "aws_ec2_image_block_public_access" "share" {
  state = "unblocked"
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
  ]
}
