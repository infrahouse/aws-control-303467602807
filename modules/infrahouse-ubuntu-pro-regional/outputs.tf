output "infrahouse-ubuntu-pro-param-arn" {
  value = aws_ssm_parameter.infrahouse-ubuntu-pro.arn
}

output "infrahouse-ubuntu-pro-latest-image-arns" {
  value = [
    for key, param in aws_ssm_parameter.infrahouse-ubuntu-pro-latest-image : param.arn
  ]
}
