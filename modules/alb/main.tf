<<<<<<< HEAD
resource "aws_elb" "test" {
  name               = "${var.name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = "${var.security_group_id}"
  subnets            = "${var.subnet_id}"

  enable_deletion_protection = true

  access_logs {
    bucket  = "${var.s3_name}"
    prefix  = "${var.name}-lb"
    enabled = true
  }

  tags {
    Environment = "test"
  }
}

variable "listener_arn" {
  type = "string"
}

data "aws_lb_listener" "listener" {
  arn = "${var.listener_arn}"
}

# get listener from load_balancer_arn and port

data "aws_lb" "selected" {
  name = "default-public"
}

data "aws_lb_listener" "selected443" {
  load_balancer_arn = "${data.aws_lb.selected.arn}"
  port              = 443
}
=======
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
>>>>>>> dev
