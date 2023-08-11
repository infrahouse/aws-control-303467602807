resource "aws_ec2_serial_console_access" "console" {
  provider = aws.aws-303467602807-uw1
  enabled  = true
}
