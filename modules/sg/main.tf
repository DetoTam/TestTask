resource "aws_security_group" "sg" {
  name = "${var.name}_sg"
  description = "str"
  vpc_id = "${var.vpc_id}"
  tags {
    Name = "${var.name}_sg"
  }
  
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = ["${var.cidr_blocks}"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["${var.cidr_blocks}"]
  }
  ingress {
    from_port   = 5555
    to_port     = 5555
    protocol    = "TCP"
    cidr_blocks = ["${var.cidr_blocks}"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

  }
  tags {
    Name = "${var.name}-alb-security-group"
  }
}

output "sg_id" {
  value = "${aws_security_group.sg.id}"
}