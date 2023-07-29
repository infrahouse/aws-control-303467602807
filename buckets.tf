module "infrahouse-omnibus-cache" {
  source = "./modules/omnibus-cache"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  bucket_name = "infrahouse-omnibus-cache"
}
