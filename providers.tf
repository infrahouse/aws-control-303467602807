provider "aws" {
  alias  = "aws-303467602807-uw1"
  region = "us-west-1"
  assume_role {
    role_arn = "arn:aws:iam::303467602807:role/ih-tf-aws-control-303467602807-admin"
  }
  default_tags {
    tags = {
      "created_by" : "infrahouse/aws-control-303467602807" # GitHub repository that created a resource
    }
  }
}
