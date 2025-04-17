output "instance_id" {
  description = "ID de l'instance EC2 créée"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "Adresse IP publique de l'instance EC2"
  value       = aws_instance.web.public_ip
}

output "security_group_id" {
  description = "ID du groupe de sécurité associé à l'instance EC2"
  value       = aws_security_group.ec2_sg.id
} 