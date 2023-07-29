output "bucket_name" {
  value = aws_s3_bucket.omnibus-cache.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.omnibus-cache.arn
}
