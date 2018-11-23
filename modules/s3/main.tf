resource "aws_s3_bucket" "test" {
  bucket = "${var.name}_bucket_test"
  acl = "private"
}

output "s3_name" {
    value = "${aws_s3_bucket.test.bucket}"
}