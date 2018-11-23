resource "aws" "vpc" {
  cidr_block = "${var.vpc_cird}"
  tags {
    Name = "${var.name}_vpc"
  }
}

resource "aws_internet_gateway" "public" {
  vpc_id = "${aws.vpc.id}"
  tags { Name = "${var.name}_gateway" }
}

resource "aws" "route_table" {
  vpc_id = "${aws.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.public.id}"
  }
  tags {
    Name = "${var.name}_route_table"
  }
}

output "vpc_id" {
  value = "${aws.vpc.id}"
}
output "route_table_id" {
  value = "${aws.route_table.id}"
}