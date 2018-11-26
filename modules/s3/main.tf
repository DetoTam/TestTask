resource "aws_s3_bucket" "str" {
  bucket = "${var.name}_bucket_str"
  acl = "private"
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.str.bucket}"
  key = "<object key name>"
  source = "./content"
}

output "s3_name" {
    value = "${aws_s3_bucket.str.bucket}"
}