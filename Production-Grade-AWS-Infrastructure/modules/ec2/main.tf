resource "aws_instance" "bastion_host" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id

  vpc_security_group_ids      = [var.security_group_id]

  associate_public_ip_address = true

  tags = {
    Name = "Bastion Host"
  }
}
resource "aws_key_pair" "bastion_key" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_ed25519.pub")  # or pass if needed
}