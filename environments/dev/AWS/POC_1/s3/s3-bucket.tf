resource "aws_s3_bucket" "main" {
    bucket = "my-app-static-assets"
    acl    = "private"

    lifecycle {
        prevent_destroy = true
    }
}

output "bucket_name" {
    value = aws_s3_bucket.main.bucket
}
