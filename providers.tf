provider "aws" {
  region = "us-west-1"
  assume_role {
    role_arn = "arn:aws:iam::303467602807:role/ih-tf-aws-control-303467602807-admin"
  }
  default_tags {
    tags = var.default_tags
  }
}

provider "aws" {
  alias  = "aws-303467602807-uw1"
  region = "us-west-1"
  assume_role {
    role_arn = "arn:aws:iam::303467602807:role/ih-tf-aws-control-303467602807-admin"
  }
  default_tags {
    tags = var.default_tags
  }
}

provider "aws" {
  alias  = "aws-303467602807-ue1"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::303467602807:role/ih-tf-aws-control-303467602807-admin"
  }
  default_tags {
    tags = var.default_tags
  }
}

provider "aws" {
  alias  = "aws-303467602807-ue2"
  region = "us-east-2"
  assume_role {
    role_arn = "arn:aws:iam::303467602807:role/ih-tf-aws-control-303467602807-admin"
  }
  default_tags {
    tags = var.default_tags
  }
}
