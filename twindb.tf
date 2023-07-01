resource "aws_iam_policy" "TwinDBTestRunner" {
  provider    = aws.aws-303467602807-uw1
  name        = "TwinDBTestRunner"
  description = "Policy for TwinDB Backup integration tests"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:PutObject",
            "s3:GetObject",
            "s3:DeleteObject"
          ],
          "Resource" : [
            "arn:aws:s3:::twindb-backup-test-*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "s3:ListBucket",
          "Resource" : "arn:aws:s3:::twindb-backup-test-*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:CreateBucket",
            "s3:DeleteBucket",
          ],
          "Resource" : [
            "arn:aws:s3:::twindb-backup-test-*"
          ]
        }
      ]
    }
  )
}

resource "aws_iam_user" "twindb_test_runner" {
  provider = aws.aws-303467602807-uw1
  name     = "twindb_test_runner"
}

resource "aws_iam_access_key" "twindb_test_runner" {
  provider = aws.aws-303467602807-uw1
  user     = aws_iam_user.twindb_test_runner.name
}

resource "aws_iam_user_policy_attachment" "twindb_test_runner" {
  provider   = aws.aws-303467602807-uw1
  policy_arn = aws_iam_policy.TwinDBTestRunner.arn
  user       = aws_iam_user.twindb_test_runner.name
}
