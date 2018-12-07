resource "aws_key_pair" "key" {
  key_name = "project_key_deto"
  public_key = "${file("${var.key_path}")}"
}

output "key_pair_id" {
  value = "${aws_key_pair.key.id}"
}
