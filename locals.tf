locals {
  environment   = "development"
  sso_admin_arn = one(data.aws_iam_roles.sso-admin.arns)
}
