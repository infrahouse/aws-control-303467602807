terraform {
  backend "s3" {
    bucket = "infrahouse-aws-control-303467602807"
    key    = "terraform.tfstate"
    region = "us-west-1"
    assume_role = {
      role_arn = "arn:aws:iam::289256138624:role/ih-tf-aws-control-303467602807-state-manager"
    }
    dynamodb_table = "infrahouse-terraform-state-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.11"
    }
  }
}
