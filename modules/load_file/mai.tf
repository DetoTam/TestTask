resource "aws_s3_bucket_object" "object" {
  bucket = "${var.s3_name}"
  key = "${var.key_name_file}"
  source = "${var.source_s3_path}"
} 