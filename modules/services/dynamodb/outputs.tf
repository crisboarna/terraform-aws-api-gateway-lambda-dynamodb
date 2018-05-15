output "dynamodb_table_names" {
  value = ["${aws_dynamodb_table.table.*.name}"]
}