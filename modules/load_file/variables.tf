variable "s3_name" {}
variable "key_name_file" {
  description = "The name of the object once it is in the bucket"
}

variable "source_s3_path" {
  description = "The path to a file that will be read and uploaded as raw bytes for the object content"
}





