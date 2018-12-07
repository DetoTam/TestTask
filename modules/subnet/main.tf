<<<<<<< HEAD
resource "aws" "subnet" {
=======
resource "aws_subnet" "subnet" {
>>>>>>> dev
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.cidr_block}"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "${var.name}_subnet"
  }
}
output "subnet_id" {
<<<<<<< HEAD
  value = "${aws.subnet.id}"
=======
  value = "${aws_subnet.subnet.id}"
>>>>>>> dev
}

