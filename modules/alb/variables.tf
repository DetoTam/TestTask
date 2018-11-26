variable "name" {
  default = "str"
}
variable "aws_instance_id" {}

variable "availability_zone" {
  type = "list"
  default = ["us-east-1a", "us-east-1b"]
  description = "Availability zone"
}