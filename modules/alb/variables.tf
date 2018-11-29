variable "name" {
  default = "str"
}

variable "security_groups_id" {
  description = "A list of security group IDs to assign to the LB"
  }

variable "vpc_id" {}

variable "subnet_id" {
  type = "list"
}

variable "s3_name" {}

variable "target_id" {
  type = "list"
}


