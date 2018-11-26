resource "aws" "subnet" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.cidr_block}"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "${var.name}_subnet"
  }
}
output "subnet_id" {
  value = "${aws.subnet.id}"
}

