variable "name" {
  default = "deto"
}
variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAkCunLXXp+/jOWtzFjWxGMdMOxz13iGHXihJEvQGeAyr4mvlrGXuGpToOJRHvUBU4IxFw5gLZBkvex4Qd3oIon60wh/sTSOcSiJToMVH/F5OyDauQmNKY0RiDPm+p2ZinvhdcH2zKER2r2gBx1ryCS4bXbsy+oRRb5d2N+3RlkKdHNLXlTyLOgfTO+XemxsJqHpSTQcb8fW5+oYFhD3JDiE49G+Z+qAKnD9xNwTaBMrA7fSPosRyG3QUGhS5cSmzhzH4XM10KGiscgmBIbyD0XXCayYH+qMC5egMFiw70Cm1IxtfoQMXAAtBB03vmxTXwjZCRQfzUTapNzqzt5eTsVQ== roman.zhulia@globallogic.com"
}

variable "region" {
  default = "eu-west-1"
}

variable "instance_type" {
  default = "m4.large"
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
