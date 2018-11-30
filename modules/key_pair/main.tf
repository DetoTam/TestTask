resource "aws_key_pair" "key" {
  key_name   = "${var.name}-key"
  public_key = "${var.public_key}"
}

output "key_name" {
  value = "${aws_key_pair.key.key_name}"
}
