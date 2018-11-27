variable "name" {
  default = "str"
}
variable "region" {
  default = "eu-west-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-028779930ada5200c"
}

variable "admin_password" {
  description = "Windows Administrator password to login as."
  default = "123Abc+-=" 
}
# variable "acces_key" {
#   default = "******"
# }

# variable "secret_key" {
#   default = "******"
#}
variable "vpc_cird" {
  default = "10.0.0.0/16"
  description = "VPC cird block"
}
variable "subnet_cird" {
  type = "list"
  default = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "Subnet cird block"
}
variable "availability_zone" {
  type = "list"
  default = ["us-east-1a", "us-east-1b"]
  description = "Availability zone"
}

variable "key_name_file" {
  description = "The name of the object once it is in the bucket"
  default = "index.html"
}

variable "source_s3_path" {
  description = "The path to a file that will be read and uploaded as raw bytes for the object content"
  default = "./content"
}
