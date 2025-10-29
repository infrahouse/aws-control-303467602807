module "registry" {
  source  = "registry.ci-cd.infrahouse.com/infrahouse/registry/aws"
  version = "0.2.0"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  cognito_users = [
    {
      email     = "aleks@infrahouse.com"
      full_name = "Aleks"
    }
  ]
  environment      = local.environment
  subnets_backend  = module.management.subnet_private_ids
  subnets_frontend = module.management.subnet_public_ids
  zone_id          = module.infrahouse_com.infrahouse_zone_id
}
