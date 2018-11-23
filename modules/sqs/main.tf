resource "aws_sqs_queue" "sqs" {
  name                      = "${var.name}_sqs"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags {
    Environment = "${var.name}_sqs"
  }
}

output "aws_sqs_queue_name" {
  value = "${aws_sqs_queue.sqs.name}"
}