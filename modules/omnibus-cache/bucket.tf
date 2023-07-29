resource "aws_s3_bucket" "omnibus-cache" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "omnibus-cache" {
  bucket = aws_s3_bucket.omnibus-cache.bucket
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "omnibus-cache" {
  bucket                  = aws_s3_bucket.omnibus-cache.bucket
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_acl" "omnibus-cache" {
  bucket = aws_s3_bucket.omnibus-cache.bucket
  acl    = "public-read"
  depends_on = [
    aws_s3_bucket_public_access_block.omnibus-cache,
    aws_s3_bucket_ownership_controls.omnibus-cache
  ]
}

data "aws_iam_policy_document" "public-access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.omnibus-cache.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "public-access" {
  bucket = aws_s3_bucket.omnibus-cache.bucket
  policy = data.aws_iam_policy_document.public-access.json
  depends_on = [
    aws_s3_bucket_acl.omnibus-cache,
    aws_s3_bucket_public_access_block.omnibus-cache,
    aws_s3_bucket_public_access_block.omnibus-cache,
    aws_s3_bucket_ownership_controls.omnibus-cache,
  ]
}
