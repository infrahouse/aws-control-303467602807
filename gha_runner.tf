locals {
  github_actions_role = "actions-runner"
}
data "aws_secretsmanager_secret" "github-terraform-app-key" {
  name = "action-runner-pem-20241116182707976200000001"
}

module "actions-runner" {
  source  = "registry.infrahouse.com/infrahouse/actions-runner/aws"
  version = "~> 2.4"

  environment                = local.environment
  github_org_name            = "infrahouse"
  github_app_id              = 1016363
  github_app_pem_secret_arn  = data.aws_secretsmanager_secret.github-terraform-app-key.arn
  subnet_ids                 = module.management.subnet_private_ids
  role_name                  = local.github_actions_role
  instance_type              = "t3a.small"
  root_volume_size           = 64
  max_instance_lifetime_days = 5
  ubuntu_codename            = "oracular"
  extra_labels               = ["oracular", "hugo"]
  puppet_hiera_config_path   = "/opt/infrahouse-puppet-data/environments/${local.environment}/hiera.yaml"
  packages = [
    "infrahouse-puppet-data",
    "nodejs",
    "hugo"
  ]
}
