resource "aws_s3_bucket" "main" {
  bucket = "${var.project_name}-data-${random_string.bucket_suffix.result}"

  tags = {
    Name = "${var.project_name}-data-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}
