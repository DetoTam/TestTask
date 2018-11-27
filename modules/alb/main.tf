resource "aws_lb" "alb" {
  name               = "${var.name}-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.security_groups_id}"]
  subnets            = ["${var.subnet_id}"]
  enable_deletion_protection = true
  access_logs {
    bucket  = "${var.s3_name}"
    prefix  = "test-lb"
    enabled = true
  }
  tags {
    Environment = "tst"
  }
}
resource "aws_lb_target_group" "alb" {
  name     = "${var.name}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}
resource "aws_lb_target_group_attachment" "alb" {
  target_group_arn = "${aws_lb_target_group.alb.arn}"
  target_id        = "${var.target_id}"
  port             = 80
}

resource "aws_lb_listener" "alb" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.alb.arn}"
  }
}
