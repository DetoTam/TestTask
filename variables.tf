variable "name" {
  default = "str"
}
variable "region" {
  default = "eu-west-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0d138b26f46625e2f"
}
variable "root_volume_size" {
  default = "30"
}
variable "root_volume_type" {
  default = "gp2"
}

variable "admin_password" {
  description = "Windows Administrator password to login as."
  default = "123Abc+-=" 
}

variable "instance_username" {
 default = "admin" 
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
variable "route_cird" {
  default = "10.1.0.0/22"
  description = "VPC cird block"
}
variable "subnet_cird" {
  type = "list"
  default = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "Subnet cird block"
}
variable "availability_zone" {
  type = "list"
  default = ["eu-west-1a", "eu-west-1b"]
  description = "Availability zone"
}

variable "key_name_file" {
  description = "The name of the object once it is in the bucket"
  default = "index.html"
}

variable "source_s3_path" {
  description = "The path to a file that will be read and uploaded as raw bytes for the object content"
  default = "./content/index.html"
}
