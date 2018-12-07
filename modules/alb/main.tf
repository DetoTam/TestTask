resource "aws_lb" "alb" {
  name               = "${var.name}-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.security_groups_id}"]
  subnets            = ["${element(var.subnet_id, 0)}", "${element(var.subnet_id, 1)}"]
  enable_deletion_protection = true

  tags {
    Environment = "tst"
  }
}
resource "aws_lb_target_group" "alb" {
  name     = "${var.name}-lb-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}
resource "aws_lb_target_group_attachment" "alb_1a" {
  target_group_arn = "${aws_lb_target_group.alb.arn}"
  target_id        = "${element(var.target_id, 0)}"
  port             = 8080
}

resource "aws_lb_target_group_attachment" "alb_1b" {
  target_group_arn = "${aws_lb_target_group.alb.arn}"
  target_id        = "${element(var.target_id, 1)}"
  port             = 8080
}

resource "aws_lb_listener" "alb" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = 5555
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.alb.arn}"
  }
}
