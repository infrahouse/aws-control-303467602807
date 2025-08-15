module "infrahouse-ubuntu-pro-key" {
  source  = "infrahouse/key/aws"
  version = "0.2.0"

  environment     = var.environment
  key_description = "Encryption key for encrypting SSM params passed to infrahouse-ubuntu-pro GitHub Actions job."
  key_name        = "infrahouse-ubuntu-pro"
  service_name    = "infrahouse-ubuntu-pro"
  key_users = [
    var.github_role_arn
  ]
}
