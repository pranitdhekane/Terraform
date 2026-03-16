output "instance_id" {
    value = aws_instance.ec-2.id
  
}

output "instance_public_ip" {
    value = aws_instance.ec-2.public_ip
  
}