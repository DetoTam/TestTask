
resource "aws_s3_bucket" "bucket" {
	bucket = "${var.name}-bucket-tst"
	acl = "private"
    tags {
        Name        = "${var.name}-bucket-tst"
        Environment = "tst"
  }
}

data "aws_iam_policy_document" "lock_it_down" {
	statement {
		sid = "AllowReadFromVPC"
		effect = "Allow"
		principals {
			type = "AWS"
			identifiers = ["*"]
		}
		actions = [
			"s3:List*", 
			"s3:Get*"]
		resources = [
			"${aws_s3_bucket.bucket.arn}",
			"${aws_s3_bucket.bucket.arn}/*"
		]
	}
}

resource "aws_s3_bucket_policy" "repo" {
	bucket = "${aws_s3_bucket.bucket.bucket}"
	policy = "${data.aws_iam_policy_document.lock_it_down.json}"
}


output "s3_name" {
    value = "${aws_s3_bucket.bucket.bucket}"
}
output "s3_bucket_id" {
  value = "${aws_s3_bucket.bucket.id}"
}

