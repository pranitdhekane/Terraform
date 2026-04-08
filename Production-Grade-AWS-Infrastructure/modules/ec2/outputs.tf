output "bastion_public_ip" {
  value = aws_instance.bastion_host.public_ip
}

output "bastion_id" {
  value = aws_instance.bastion_host.id
}