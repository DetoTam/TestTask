<<<<<<< HEAD
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
=======
resource "aws_vpc" "str" {
  cidr_block       = "${var.vpc_cird}"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags {
    Name = "${var.name}_vpc"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "public" {
  vpc_id = "${aws_vpc.str.id}"
  tags { Name = "Public Gateway ${var.name}-gateway" }
}
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.str.id}"
>>>>>>> dev
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.public.id}"
  }
<<<<<<< HEAD
=======

>>>>>>> dev
  tags {
    Name = "${var.name}_route_table"
  }
}

output "vpc_id" {
<<<<<<< HEAD
  value = "${aws.vpc.id}"
}
output "route_table_id" {
  value = "${aws.route_table.id}"
}
=======
  value = "${aws_vpc.str.id}"
}
output "route_table_id" {
  value = "${aws_route_table.public.id}"
}
>>>>>>> dev
