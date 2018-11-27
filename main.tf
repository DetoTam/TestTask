provider "aws" {
  region = "${var.region}"
  #access_key = "${var.acces_key}"
  #secret_key = "${var.secret_key}"
}
module "network" {
  source = "./modules/network"
  vpc_cird = "${var.vpc_cird}"
  route_cird = "${var.route_cird}"
}

module "subnet_1a" {
  source = "./modules/subnet"
  vpc_id = "${module.network.vpc_id}"
  cidr_block = "${element(var.subnet_cird, 0)}"
  availability_zone = "${element(var.availability_zone, 0)}"
}

module "subnet_1b" {
  source = "./modules/subnet"
  vpc_id = "${module.network.vpc_id}"
  cidr_block = "${element(var.subnet_cird, 1)}"
  availability_zone = "${element(var.availability_zone, 1)}"
}

module "route_association_1a" {
  source = "./modules/route_association"
  route_table_id = "${module.network.route_table_id}"
  subnet_id = "${module.subnet_1a.subnet_id}"
}

module "route_association_1b" {
  source = "./modules/route_association"
  route_table_id = "${module.network.route_table_id}"
  subnet_id = "${module.subnet_1b.subnet_id}"
}

module "sg" {
  source = "./modules/sg"
  vpc_id = "${module.network.vpc_id}"
  cidr_blocks = "${var.vpc_cird}"
}

module "iam" {
  source = "./modules/iam"
  s3_name = "${module.s3.s3_name}"
  sqs_name = "${module.sqs.aws_sqs_queue_name}"
}
module "sqs" {
  source = "./modules/sqs"
}
module "s3" {
  source = "./modules/s3"
}

module "load_file" {
  source = "./modules/load_file"
  s3_name = "${module.s3.s3_name}"
  key_name_file = "${var.key_name_file}"
  source_s3_path = "${var.source_s3_path}"
}

module "ec2_1a" {
  source = "./modules/ec2"
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  admin_password = "${var.admin_password}"
  subnet_id = "${module.subnet_1a.subnet_id}"
  availability_zone = "${element(var.availability_zone, 0)}"
  sg_id = "${module.sg.sg_id}"
  ec2_profile = "${module.iam.ec2_profile}"
}

module "ec2_1b" {
  source = "./modules/ec2"
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  admin_password = "${var.admin_password}"
  subnet_id = "${module.subnet_1b.subnet_id}"
  availability_zone = "${element(var.availability_zone, 1)}"
  sg_id = "${module.sg.sg_id}"
  ec2_profile = "${module.iam.ec2_profile}"
}

module "loadbalancer" {
  source = "./modules/alb"
  s3_name = "${module.s3.s3_name}"
  security_groups_id = "${module.sg.sg_id}"
  vpc_id = "${module.network.vpc_id}"
  target_id = "${module.ec2_1a.aws_instance_id}, ${module.ec2_1b.aws_instance_id}"
  subnet_id = "${module.subnet_1a.subnet_id}, ${module.subnet_1b.subnet_id}"


  
}
