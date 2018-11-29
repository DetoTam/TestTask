resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}-bucket-tst"
  acl    = "private"
  
  tags {
    Name        = "${var.name}-bucket-tst"
    Environment = "tst"
  }
}

resource "aws_s3_bucket_policy" "str" {
  bucket = "${aws_s3_bucket.bucket.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}/*",
      "Condition": {
         "IpAddress": {"aws:SourceIp": "8.8.8.8/32"}
      }
    }
  ]
}
POLICY
}



output "s3_name" {
    value = "${aws_s3_bucket.bucket.bucket}"
}
output "s3_bucket_id" {
  value = "${aws_s3_bucket.bucket.id}"
}

