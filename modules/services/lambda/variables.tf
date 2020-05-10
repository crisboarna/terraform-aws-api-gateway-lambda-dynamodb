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

variable "lambda_file_name" {
  description = "Path to lambda code zip"
}

variable "lambda_code_s3_bucket_new" {
  description = "S3 bucket with source code"
}

variable "lambda_code_s3_bucket_use_existing" {
  description = "Boolean flag to specify whether to use 'lambda_code_s3_bucket_new' and create new bucket or to use 'lambda_code_s3_bucket_existing and use existing S3 bucket and now a generate new one"
}

variable "lambda_code_s3_bucket_existing" {
  description = "Existing 'aws_s3_bucket.bucket'"
}

variable "lambda_code_s3_key" {
  description = "Location of Lambda code in S3 bucket"
}

variable "lambda_code_s3_storage_class" {
  description = "Lambda code S3 storage class"
}

variable "lambda_code_s3_bucket_visibility" {
  description = "S3 bucket ACL"
}

variable "lambda_zip_path" {
  description = "Local path to Lambda source dist"
}

variable "lambda_memory_size" {
  description = "Lambda memory size"
  default = 128
}

variable "lambda_vpc_security_group_ids" {
  description = "Lambda VPC Security Group IDs"
  type = list(string)
  default = []
}

variable "lambda_vpc_subnet_ids" {
  description = "Lambda VPC Subnet IDs"
  type = list(string)
  default = []
}

variable "lambda_layers" {
  description = "Lambda Layer ARNS"
  type = list(string)
  default = []
}