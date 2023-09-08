resource "aws_iam_user" "tc-test" {
  provider = aws.aws-303467602807-uw1
  name     = "tc_test"
}

resource "aws_iam_access_key" "tc-test" {
  provider = aws.aws-303467602807-uw1
  user     = aws_iam_user.tc-test.name
}

resource "aws_iam_user_policy_attachment" "tc-test" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.TwinDBTestRunner.arn
  user       = aws_iam_user.tc-test.name
}
