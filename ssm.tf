resource "aws_ssm_parameter" "gh_secrets_namespace" {
  provider       = aws.aws-303467602807-uw1
  name           = "gh_secrets_namespace"
  type           = "String"
  insecure_value = "_github_control__"
}
