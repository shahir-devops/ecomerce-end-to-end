output "db_instance_identifier" {
  value = aws_db_instance.rds.identifier
}
output "db_endpoint" {
  value = aws_db_instance.rds.endpoint
}