module "ec2_instance" {
  source = "./modules/ec2_instance"

  region        = var.region
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_id        = var.vpc_id
  public_key    = var.public_key
}

