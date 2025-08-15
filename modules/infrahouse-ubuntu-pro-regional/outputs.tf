output "infrahouse-ubuntu-pro-param-arn" {
  value = aws_ssm_parameter.infrahouse-ubuntu-pro.arn
}

output "infrahouse-ubuntu-pro-latest-image-arns" {
  value = [
    for cn in var.supported_codenames : aws_ssm_parameter.infrahouse-ubuntu-pro-latest-image[cn].arn
  ]
}
