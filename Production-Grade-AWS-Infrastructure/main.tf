provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "ec2" {
  source = "./modules/ec2"

  instance_type = var.instance_type
  ami_id        = var.ami_id
  key_name      = var.key_name

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_ids[0] # ✅ bastion in public subnet

  # ✅ IMPORTANT: pass SG from sgs module
  security_group_id = module.sgs.instance_sg_id
}



module "sgs" {
  source = "./modules/sgs"
  vpc_id = module.vpc.vpc_id
}


module "auto" {
  source = "./modules/autoscaling"

  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids
  alb_subnet_ids = module.vpc.public_subnet_ids

  instance_type = var.instance_type
  ami_id        = var.ami_id
  key_name      = var.key_name

  instance_sg_id = module.sgs.instance_sg_id
  alb_sg_id      = module.sgs.alb_sg_id
}
