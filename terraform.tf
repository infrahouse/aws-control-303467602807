terraform {
  #  backend "local" {}
  backend "s3" {
    bucket         = "infrahouse-aws-control-303467602807"
    key            = "terraform.tfstate"
    region         = "us-west-1"
    role_arn       = "arn:aws:iam::289256138624:role/ih-tf-terraform-control"
    dynamodb_table = "infrahouse-terraform-state-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67"
    }
  }
}
