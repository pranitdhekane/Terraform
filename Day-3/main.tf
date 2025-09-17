provider "aws" {
  region = "ap-south-1"

}

module "EC2" {
  source        = "./modules/EC2"
  ami_id        = "ami-02d26659fd82cf299"
  subnet        = "subnet-02b8b5313a0ac4bc3"
  instance_type = "t2.micro"
}
