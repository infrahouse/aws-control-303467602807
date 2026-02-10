module "github_backup_pem" {
  source             = "registry.infrahouse.com/infrahouse/secret/aws"
  version            = "~> 1.1"
  environment        = local.environment
  service_name       = "github-backup-test"
  secret_description = "GitHub Backup App PEM key for CI testing"
  secret_name_prefix = "github-backup-test-pem"
  readers            = [module.ci-tester["github-backup-tester"].role_arn]
  writers            = tolist(data.aws_iam_roles.sso-admin.arns)
  providers = {
    aws = aws.aws-303467602807-uw1
  }
}

module "github_backup_pem_uw2" {
  source             = "registry.infrahouse.com/infrahouse/secret/aws"
  version            = "~> 1.1"
  environment        = local.environment
  service_name       = "github-backup-test"
  secret_description = "GitHub Backup App PEM key for CI testing"
  secret_name_prefix = "github-backup-test-pem"
  secret_value       = module.github_backup_pem.secret_value
  readers            = [module.ci-tester["github-backup-tester"].role_arn]
  writers            = tolist(data.aws_iam_roles.sso-admin.arns)
  providers = {
    aws = aws.aws-303467602807-uw2
  }
}

module "github_backup_pem_ue1" {
  source             = "registry.infrahouse.com/infrahouse/secret/aws"
  version            = "~> 1.1"
  environment        = local.environment
  service_name       = "github-backup-test"
  secret_description = "GitHub Backup App PEM key for CI testing"
  secret_name_prefix = "github-backup-test-pem"
  secret_value       = module.github_backup_pem.secret_value
  readers            = [module.ci-tester["github-backup-tester"].role_arn]
  writers            = tolist(data.aws_iam_roles.sso-admin.arns)
  providers = {
    aws = aws.aws-303467602807-ue1
  }
}
