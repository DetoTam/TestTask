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
  route {
    cidr_block = "0.0.0.0/0"
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
