module "github-connector" {
  source = "github.com/infrahouse/terraform-aws-gh-identity-provider"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
}
