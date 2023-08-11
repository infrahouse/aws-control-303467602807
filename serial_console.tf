resource "aws_ec2_serial_console_access" "console-uw1" {
  provider = aws.aws-303467602807-uw1
  enabled  = true
}

resource "aws_ec2_serial_console_access" "console-ue1" {
  provider = aws.aws-303467602807-ue1
  enabled  = true
}

resource "aws_ec2_serial_console_access" "console-ue2" {
  provider = aws.aws-303467602807-ue1
  enabled  = true
}
