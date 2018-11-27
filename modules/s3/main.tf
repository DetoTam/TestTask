resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}-bucket-tst"
  acl    = "private"

  tags {
    Name        = "${var.name}-bucket-tst"
    Environment = "tst"
  }
}

output "s3_name" {
    value = "${aws_s3_bucket.bucket.bucket}"
}

