output "db_endpoint" {
  value       = aws_db_instance.database.endpoint
  description = "Endpoint do banco de dados"
}
