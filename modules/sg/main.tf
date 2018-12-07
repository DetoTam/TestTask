resource "aws_security_group" "sg" {
  name = "${var.name}_sg"
  description = "str"
  vpc_id = "${var.vpc_id}"
  tags {
<<<<<<< HEAD
    Name = ["${var.name}_sg"]
  }
  

=======
    Name = "${var.name}-security-group"
  }
    
>>>>>>> dev
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
<<<<<<< HEAD
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]  
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]  
=======
  
  ingress {
    from_port   = 5985 #winrm
    to_port     = 5986
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5555
    to_port     = 5555
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
>>>>>>> dev
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
<<<<<<< HEAD

  }
}

=======
  }
}
>>>>>>> dev
output "sg_id" {
  value = "${aws_security_group.sg.id}"
}