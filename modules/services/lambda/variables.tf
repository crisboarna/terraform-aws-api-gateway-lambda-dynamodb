#TAGS
variable "tags" {
  type = "map"
  description = "Tags for lambda"
  default = {}
}

# ENV VARS
variable "environment_variables" {
  type = "map"
  description = "Environment variables"
}

#SETUP
variable "region" {
  description = "Region of Lambda & S3 source code"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
}

variable "lambda_description" {
  description = "Lambda description"
}

variable "lambda_runtime" {
  description = "The runtime of the Lambda to create"
}

variable "lambda_handler" {
  description = "The name of Lambda function handler"
}

variable "lambda_role" {
  description = "IAM role attached to Lambda function - ARN"
}

variable "lambda_timeout" {
  description = "Maximum runtime for Lambda"
  default = 30
}

variable "lambda_code_s3_bucket" {
  description = "S3 bucket with source code"
}

variable "lambda_code_s3_key" {
  description = "The S3 key of source code"
}

variable "lambda_code_s3_storage_class" {
  default = "ONEZONE_IA"
  description = "S3 object storage class"
}

variable "lambda_code_s3_bucket_visibility" {
  default = "private"
  description = "S3 bucket ACL"
}

variable "lambda_zip_path" {
  description = "Local path to Lambda source dist"
}

variable "lambda_memory_size" {
  description = "Lambda memory size"
  default = 128
}
