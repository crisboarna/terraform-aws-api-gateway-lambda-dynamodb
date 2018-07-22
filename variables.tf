#TAGS
variable "tags" {
  type = "map"
  description = "Tags for lambda"
  default = {}
}


#Environment variables
variable "environment_variables" {
  type = "map"
  description = "Azure Bot Subscription ID"
}


#SETUP

#Global
variable "region" {
  description = "Region to deploy in"
}

variable "project" {
  description = "Name of project"
}

#Lambda
variable "lambda_function_name" {
  description = "Local path to Lambda zip code"
}

variable "lambda_description" {
  default = ""
  description = "Lambda description"
}

variable "lambda_runtime" {
  description = "Lambda runtime"
}

variable "lambda_handler" {
  description = "Lambda handler path"
}

variable "lambda_timeout" {
  description = "Maximum runtime for Lambda"
  default = 30
}

variable "lambda_code_s3_bucket" {
  description = "Location of Lambda code in S3"
}

variable "lambda_code_s3_key" {
  description = "Location of Lambda code in S3 bucket"
}

variable "lambda_code_s3_storage_class" {
  description = "Lambda code S3 storage class"
  default = "ONEZONE_IA"
}

variable "lambda_code_s3_bucket_visibility" {
  default = "private"
  description = "S3 bucket ACL"
}

variable "lambda_zip_path" {
  description = "Local path to Lambda zip code"
}

variable "lambda_memory_size" {
  description = "Lambda memory size"
}


#API Gateway Setup
variable "api_gw_method" {
  description = "API Gateway method (GET,POST...)"
  default = "POST"
}

variable "api_gw_dependency_list" {
  description = "List of aws_api_gateway_integration* that require aws_api_gateway_deployment dependency"
  type = "list"
}

#DynamoDB
variable "dynamodb_table_properties" {
  type = "list"
  description = "List of maps representing a table each. name (required), read_capacity(default=1), write_capacity(default=1), hash_key(required)"
}

variable "dynamodb_table_attributes" {
  type = "list"
  description = "List of list of maps representing each table attributes list. Required due to current HCL limitations"
}

variable "dynamodb_table_secondary_index" {
  type = "list"
  default = [[]]
  description = "List of list of maps representing each table secondary index list. Required due to current HCL limitations"
}

variable "dynamodb_policy_action_list" {
  description = "List of Actions to be executed"
  type = "list"
  default = ["dynamodb:DescribeTable", "dynamodb:DeleteItem", "dynamodb:GetItem", "dynamodb:Scan", "dynamodb:Query"]
}