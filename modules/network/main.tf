resource "aws_vpc" "str" {
  cidr_block       = "${var.vpc_cird}"
  instance_tenancy = "dedicated"

  tags {
    Name = "${var.name}_vpc"
  }
}

resource "aws_internet_gateway" "public" {
  vpc_id = "${aws_vpc.str.id}"
  tags { Name = "${var.name}_gateway" }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.str.id}"

  route {
    cidr_block = "${var.route_cird}"
    gateway_id = "${aws_internet_gateway.public.id}"
  }
  tags {
    Name = "${var.name}_route_table"
  }
}

output "vpc_id" {
  value = "${aws_vpc.str.id}"
}
output "route_table_id" {
  value = "${aws_route_table.public.id}"
}
