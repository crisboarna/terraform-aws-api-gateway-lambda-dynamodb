#TAGS
variable "tags" {
  type = "map"
  description = "Tags for lambda"
  default = {}
}

#Setup
variable "table_data" {
  type = "list"
  description = "List of maps representing a table each. name (required), read_capacity(default=1), write_capacity(default=1)"
}