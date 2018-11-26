resource "aws_s3_bucket" "object" {
  bucket = "${var.s3_name}"
  source = "${var.source_path}"
  
}
