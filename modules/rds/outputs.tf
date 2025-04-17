output "rds_endpoint" {
  description = "Endpoint pour se connecter à la base de données"
  value       = aws_db_instance.database.endpoint
}

output "db_name" {
  description = "Nom de la base de données"
  value       = aws_db_instance.database.db_name
}

output "security_group_id" {
  description = "ID du groupe de sécurité de la base de données"
  value       = aws_security_group.rds_sg.id
} 