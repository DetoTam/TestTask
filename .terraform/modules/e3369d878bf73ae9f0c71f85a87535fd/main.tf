resource "aws_route_table_association" "str" {
  route_table_id = "${var.route_table_id}"
  subnet_id = "${var.subnet_id}"
  tags {
    Name = "${var.name}_route_table_association"
  }
}