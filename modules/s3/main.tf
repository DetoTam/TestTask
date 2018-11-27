resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}_bucket_tst"
  acl    = "private"

  tags {
    Name        = "${var.name}_bucket"
    Environment = "TST"
  }
}

output "s3_name" {
    value = "${aws_s3_bucket.bucket.bucket}"
}

