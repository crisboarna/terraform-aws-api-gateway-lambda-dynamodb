#TAGS
variable "tags" {
  type = "map"
  description = "Tags for lambda"
  default = {}
}

#Setup
variable "dynamodb_table_properties" {
  type = "list"
  description = "List of maps representing a table each. name (required), read_capacity(default=1), write_capacity(default=1), attributes(list), hash_key(required)"
}

variable "dynamodb_table_attributes" {
  type = "list"
  description = "List of maps representing each table attributes list. Required due to current HCL limitations"
}

variable "dynamodb_table_secondary_index" {
  type = "list"
  default = [[]]
  description = "List of list of maps representing each table secondary index list. Required due to current HCL limitations"
}