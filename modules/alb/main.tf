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