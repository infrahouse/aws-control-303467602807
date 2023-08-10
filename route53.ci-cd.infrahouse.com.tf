module "infrahouse_com" {
  source = "./modules/ci-cd.infrahouse.com"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
}
