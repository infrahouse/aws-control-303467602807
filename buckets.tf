resource "aws_s3_bucket" "infrahouse-omnibus-cache" {
  provider = aws.aws-303467602807-uw1
  bucket   = "infrahouse-omnibus-cache"
}
