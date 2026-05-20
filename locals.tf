locals {
  environment   = "development"
  dr_region     = "us-east-1"
  sso_admin_arn = one(data.aws_iam_roles.sso-admin.arns)
}
