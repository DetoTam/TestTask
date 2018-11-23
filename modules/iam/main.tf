resource "aws_iam_instance_profile" "ec2_profile" {
  name  = "${var.name}_profile"
  role = "${aws_iam_role.role_ec2.name}"
}
resource "aws_iam_role" "role_ec2" {
    name = "${var.name}_role_ec2"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_policy" "policy_s3" {
    name        = "${var.name}_policy_s3"
    description = "A test policy"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::${var.s3_name}/*"
        }
    ]
}
EOF
}
resource "aws_iam_policy" "policy_sqs" {
    name        = "${var.name}_policy_sqs"
    description = "Policy for SQS"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "sqs:*",
            "Resource": "arn:aws:sqs:::${var.sqs_name}"
        }
    ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "s3toec2" {
    role       = "${aws_iam_role.role_ec2.name}"
    policy_arn = "${aws_iam_policy.policy_s3.arn}"
}
resource "aws_iam_role_policy_attachment" "sqstoec2" {
    role       = "${aws_iam_role.role_ec2.name}"
    policy_arn = "${aws_iam_policy.policy_sqs.arn}"
}
output "ec2_profile" {
    value = "${aws_iam_instance_profile.ec2_profile.name}"
}
