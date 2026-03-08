module "infrahouse-ubuntu-pro-key" {
  source  = "registry.infrahouse.com/infrahouse/key/aws"
  version = "0.3.0"

  environment     = var.environment
  key_description = "Encryption key for encrypting SSM params passed to infrahouse-ubuntu-pro GitHub Actions job."
  key_name        = "infrahouse-ubuntu-pro"
  service_name    = "infrahouse-ubuntu-pro"
  key_users = [
    var.github_role_arn
  ]
}
