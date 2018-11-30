provider "aws" {
  region = "${var.region}"
  #access_key = "${var.acces_key}"
  #secret_key = "${var.secret_key}"
}
module "network" {
  source = "./modules/network"
  name = "${var.name}"
  vpc_cird = "${var.vpc_cird}"
  route_cird = "${var.route_cird}"
}

module "subnet_1a" {
  source = "./modules/subnet"
  name = "${var.name}"
  vpc_id = "${module.network.vpc_id}"
  cidr_block = "${element(var.subnet_cird, 0)}"
  availability_zone = "${element(var.availability_zone, 0)}"
}

module "subnet_1b" {
  source = "./modules/subnet"
  name = "${var.name}"
  vpc_id = "${module.network.vpc_id}"
  cidr_block = "${element(var.subnet_cird, 1)}"
  availability_zone = "${element(var.availability_zone, 1)}"
}

module "route_association_1a" {
  source = "./modules/route_association"
  name = "${var.name}"
  route_table_id = "${module.network.route_table_id}"
  subnet_id = "${module.subnet_1a.subnet_id}"
}

module "route_association_1b" {
  source = "./modules/route_association"
  name = "${var.name}"
  route_table_id = "${module.network.route_table_id}"
  subnet_id = "${module.subnet_1b.subnet_id}"
}

module "sg" {
  source = "./modules/sg"
  name = "${var.name}"
  vpc_id = "${module.network.vpc_id}"
  cidr_blocks = "${var.vpc_cird}"
}

module "iam" {
  source = "./modules/iam"
  name = "${var.name}"
  s3_name = "${module.s3.s3_name}"
  sqs_name = "${module.sqs.aws_sqs_queue_name}"
}
module "sqs" {
  source = "./modules/sqs"
  name = "${var.name}"
}
module "s3" {
  source = "./modules/s3"
  name = "${var.name}"
}

module "load_file" {
  source = "./modules/load_file"
  name = "${var.name}"
  s3_name = "${module.s3.s3_name}"
  key_name_file = "${var.key_name_file}"
  source_s3_path = "${var.source_s3_path}"
}

# module "key_pair" {
#   source = "./modules/key_pair"
#   name = "${var.name}"
#   public_key = "${var.public_key}"
# }

module "ec2_1a" {
  source = "./modules/ec2"
  name = "${var.name}"
  key_name = "deto_key"
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  root_volume_size = "${var.root_volume_size}"
  root_volume_type = "${var.root_volume_type}"
  admin_password = "${var.admin_password}"
  instance_username = "${var.instance_username}"
  subnet_id = "${module.subnet_1a.subnet_id}"
  availability_zone = "${element(var.availability_zone, 0)}"
  sg_id = "${module.sg.sg_id}"
  ec2_profile = "${module.iam.ec2_profile}"
}

module "ec2_1b" {
  source = "./modules/ec2"
  name = "${var.name}"
  key_name = "deto_key"
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  root_volume_size = "${var.root_volume_size}"
  root_volume_type = "${var.root_volume_type}"
  admin_password = "${var.admin_password}"
  instance_username = "${var.instance_username}"
  subnet_id = "${module.subnet_1b.subnet_id}"
  availability_zone = "${element(var.availability_zone, 1)}"
  sg_id = "${module.sg.sg_id}"
  ec2_profile = "${module.iam.ec2_profile}"
}

module "loadbalancer" {
  source = "./modules/alb"
  name = "${var.name}"
  s3_name = "${module.s3.s3_name}"
  security_groups_id = "${module.sg.sg_id}"
  vpc_id = "${module.network.vpc_id}"
  target_id = ["${module.ec2_1a.aws_instance_id}", "${module.ec2_1b.aws_instance_id}"]
  subnet_id = ["${module.subnet_1a.subnet_id}", "${module.subnet_1b.subnet_id}"]
 
}
