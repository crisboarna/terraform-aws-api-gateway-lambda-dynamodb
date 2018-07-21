resource "aws_dynamodb_table" "table" {
  count = "${length(var.dynamodb_table_properties)}"
  name = "${lookup(var.dynamodb_table_properties[count.index], "name")}"
  read_capacity = "${lookup(var.dynamodb_table_properties[count.index], "read_capacity", "1")}"
  write_capacity = "${lookup(var.dynamodb_table_properties[count.index], "write_capacity", "1")}"
  hash_key = "${lookup(var.dynamodb_table_properties[count.index], "hash_key")}"
  range_key = "${lookup(var.dynamodb_table_properties[count.index], "range_key", "")}"
  stream_enabled = "${lookup(var.dynamodb_table_properties[count.index], "stream_enabled", "")}"
  stream_view_type = "${lookup(var.dynamodb_table_properties[count.index], "stream_view_type", "")}"
  attribute = "${var.dynamodb_table_attributes[count.index]}"
  global_secondary_index = "${var.dynamodb_table_secondary_index[count.index]}"
  tags = "${var.tags}"
}