data "aws_secretsmanager_secret" "github-terraform-app-key" {
  name = "action-runner-pem-20241116182707976200000001"
}

module "actions-runner" {
  source  = "registry.infrahouse.com/infrahouse/actions-runner/aws"
  version = "2.13.1"

  environment                = local.environment
  github_org_name            = "infrahouse"
  github_app_id              = 1016363
  github_app_pem_secret_arn  = data.aws_secretsmanager_secret.github-terraform-app-key.arn
  subnet_ids                 = module.management.subnet_private_ids
  role_name                  = "actions-runner-oracular"
  instance_type              = "t3a.small"
  root_volume_size           = 64
  max_instance_lifetime_days = 5
  asg_min_size               = 1
  asg_max_size               = 1
  on_demand_base_capacity    = 0
  ubuntu_codename            = "oracular"
  extra_labels               = ["oracular", "hugo"]
  puppet_hiera_config_path   = "/opt/infrahouse-puppet-data/environments/${local.environment}/hiera.yaml"
  packages = [
    "debhelper",
    "devscripts",
    "infrahouse-puppet-data",
    "golang",
    "hugo",
    "nodejs",
    "npm",
  ]
}

module "actions-runner-noble" {
  source  = "registry.infrahouse.com/infrahouse/actions-runner/aws"
  version = "~> 2.13, >= 2.13.1"

  environment                = local.environment
  github_org_name            = "infrahouse"
  github_app_id              = 1016363
  github_app_pem_secret_arn  = data.aws_secretsmanager_secret.github-terraform-app-key.arn
  subnet_ids                 = module.management.subnet_private_ids
  role_name                  = "actions-runner-noble"
  instance_type              = "t3a.small"
  root_volume_size           = 64
  max_instance_lifetime_days = 5
  asg_min_size               = 1
  asg_max_size               = 3
  ubuntu_codename            = "noble"
  extra_labels               = ["noble"]
  puppet_hiera_config_path   = "/opt/infrahouse-puppet-data/environments/${local.environment}/hiera.yaml"
  packages = [
    "debhelper",
    "devscripts",
    "infrahouse-puppet-data",
    "golang",
  ]
}
